package test

import (
	"os"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/require"
)

func TestModulesStackWithMiniblue(t *testing.T) {
	if os.Getenv("RUN_MINIBLUE_TESTS") != "1" {
		t.Skip("set RUN_MINIBLUE_TESTS=1 to run the miniblue integration test")
	}

	t.Parallel()

	tfDir := copyToTemp(t, "07-modules")

	opts := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: tfDir,
		NoColor:      true,
		EnvVars:      miniblueEnvVars(),
	})

	defer terraform.Destroy(t, opts)
	terraform.InitAndApply(t, opts)

	resourceGroups := terraform.OutputMap(t, opts, "resource_groups")
	virtualNetworks := terraform.OutputMap(t, opts, "virtual_networks")
	subnets := terraform.OutputMap(t, opts, "subnets")
	networkSecurityGroups := terraform.OutputMap(t, opts, "network_security_groups")

	require.NotEmpty(t, resourceGroups, "expected resource group outputs")
	require.NotEmpty(t, virtualNetworks, "expected virtual network outputs")
	require.NotEmpty(t, subnets, "expected subnet outputs")
	require.NotEmpty(t, networkSecurityGroups, "expected NSG outputs")

	found := false
	for _, name := range resourceGroups {
		out := azlocalCmd(t, "group", "show", "--name", name)
		if strings.Contains(out, name) {
			found = true
			break
		}
	}
	require.True(t, found, "expected at least one Terraform output resource group to exist in miniblue")

	exitCode := terraform.PlanExitCode(t, opts)
	require.Equal(t, 0, exitCode, "expected a clean plan after apply")
}
