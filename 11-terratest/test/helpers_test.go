package test

import (
	"os"
	"path/filepath"
	"testing"

	"github.com/gruntwork-io/terratest/modules/files"
	"github.com/gruntwork-io/terratest/modules/shell"
	"github.com/stretchr/testify/require"
)

func copyToTemp(t *testing.T, relPath string) string {
	t.Helper()

	repoRoot, err := filepath.Abs(filepath.Join("..", ".."))
	require.NoError(t, err)

	src := filepath.Join(repoRoot, relPath)
	dst, err := files.CopyTerraformFolderToTemp(src, "")
	require.NoError(t, err)
	return dst
}

func azlocalCmd(t *testing.T, args ...string) string {
	t.Helper()

	cmd := shell.Command{
		Command: "azlocal",
		Args:    args,
		Env: map[string]string{
			"LOCAL_AZURE_ENDPOINT": "http://localhost:4566",
		},
	}

	return shell.RunCommandAndGetOutput(t, cmd)
}

func miniblueEnvVars() map[string]string {
	env := map[string]string{}

	if cert := os.Getenv("SSL_CERT_FILE"); cert != "" {
		env["SSL_CERT_FILE"] = cert
	}

	return env
}
