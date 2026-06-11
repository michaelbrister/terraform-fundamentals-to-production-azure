#!/usr/bin/env bash
set -euo pipefail

run_apply=0
run_go=1

usage() {
  cat <<'USAGE'
Usage: scripts/preview-smoke.sh [--apply-miniblue] [--skip-go]

Runs the Azure preview publication smoke checks.

Default checks:
  - terraform fmt -check for valid roots
  - terraform init -backend=false and terraform validate for valid roots
  - expected-failure checks for intentionally broken exercises
  - default Terratest suite

Optional:
  --apply-miniblue  Apply/destroy the preview hands-on roots against a running miniblue.
  --skip-go         Skip the default Terratest suite.
USAGE
}

for arg in "$@"; do
  case "$arg" in
    --apply-miniblue)
      run_apply=1
      ;;
    --skip-go)
      run_go=0
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $arg" >&2
      usage >&2
      exit 2
      ;;
  esac
done

log() {
  printf '\n==> %s\n' "$*"
}

require_command() {
  local command_name="$1"

  if ! command -v "$command_name" >/dev/null 2>&1; then
    echo "Missing required command: $command_name" >&2
    exit 1
  fi
}

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

require_command terraform

if [[ "$run_go" -eq 1 ]]; then
  require_command go
fi

if [[ "$run_apply" -eq 1 ]]; then
  require_command curl
fi

fmt_roots=(
  "01-local-basics"
  "02-language-basics"
  "03-for-each-patterns"
  "04-dynamic-patterns"
  "07-modules"
  "08-terraform-console"
  "09-refactor-state/step1"
  "09-refactor-state/step2"
  "09-refactor-state/step3"
  "09-refactor-state/step4"
  "09-refactor-state/step5"
  "10-breakfix/scenario-02-identity-instability"
  "10-breakfix/scenario-03-drift"
  "10-breakfix/scenario-04-locks-and-partial-ops"
  "10-breakfix/scenario-05-import-vs-recreate"
  "12-exam-drills/drill-02-count-to-for_each-no-recreate"
  "12-exam-drills/drill-03-for_each-key-stability"
  "12-exam-drills/drill-04-dynamic-optional"
  "12-exam-drills/drill-09-provider-version-conflict"
  "13-state-subcommands"
  "live/dev"
  "live/stage"
  "live/prod"
  "modules/app_stack"
)

validate_roots=(
  "01-local-basics"
  "02-language-basics"
  "03-for-each-patterns"
  "04-dynamic-patterns"
  "07-modules"
  "08-terraform-console"
  "09-refactor-state/step1"
  "09-refactor-state/step2"
  "09-refactor-state/step3"
  "09-refactor-state/step4"
  "09-refactor-state/step5"
  "10-breakfix/scenario-02-identity-instability"
  "10-breakfix/scenario-03-drift"
  "10-breakfix/scenario-04-locks-and-partial-ops"
  "10-breakfix/scenario-05-import-vs-recreate"
  "12-exam-drills/drill-02-count-to-for_each-no-recreate"
  "12-exam-drills/drill-03-for_each-key-stability"
  "12-exam-drills/drill-04-dynamic-optional"
  "13-state-subcommands"
  "live/dev"
  "live/stage"
  "live/prod"
  "modules/app_stack"
)

apply_roots=(
  "01-local-basics"
  "02-language-basics"
  "03-for-each-patterns"
  "04-dynamic-patterns"
  "07-modules"
  "13-state-subcommands"
)

log "Checking Terraform formatting"
for root in "${fmt_roots[@]}"; do
  terraform -chdir="$root" fmt -check
done

log "Validating Terraform roots"
for root in "${validate_roots[@]}"; do
  terraform -chdir="$root" init -backend=false -input=false
  terraform -chdir="$root" validate
done

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

cat >"$tmp_dir/03-for-each-patterns.tfvars" <<'TFVARS'
network_stacks = {
  smoke_app = {
    create_nsg    = true
    address_space = ["10.10.0.0/16"]
    tags          = { Purpose = "smoke-app" }
  }
}
TFVARS

cat >"$tmp_dir/04-dynamic-patterns.tfvars" <<'TFVARS'
security_groups = {
  smoke_web = {
    rules = [
      {
        name                       = "allow-https-in"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }
}
TFVARS

log "Checking intentional Terraform failures"
terraform -chdir="10-breakfix/scenario-01-parse-error" validate >"$tmp_dir/parse.out" 2>&1 && {
  cat "$tmp_dir/parse.out"
  echo "Expected parse error scenario to fail." >&2
  exit 1
}
grep -q "Missing attribute separator" "$tmp_dir/parse.out"

terraform -chdir="12-exam-drills/drill-10-dependency-cycle" validate >"$tmp_dir/cycle.out" 2>&1 && {
  cat "$tmp_dir/cycle.out"
  echo "Expected dependency cycle drill to fail." >&2
  exit 1
}
grep -q "Cycle" "$tmp_dir/cycle.out"

log "Checking provider version drill initialization"
terraform -chdir="12-exam-drills/drill-09-provider-version-conflict" init -backend=false -input=false
terraform -chdir="12-exam-drills/drill-09-provider-version-conflict" version

if command -v conftest >/dev/null 2>&1; then
  log "Checking optional policy examples with Conftest"
  conftest test policy/examples/azure-plan-pass.json -p policy

  conftest test policy/examples/azure-plan-fail.json -p policy >"$tmp_dir/policy-fail.out" 2>&1 && {
    cat "$tmp_dir/policy-fail.out"
    echo "Expected failing policy example to fail." >&2
    exit 1
  }
  grep -q "missing required tag" "$tmp_dir/policy-fail.out"
  grep -q "allows inbound traffic" "$tmp_dir/policy-fail.out"
else
  log "Skipping optional policy examples because conftest is not installed"
fi

if [[ "$run_go" -eq 1 ]]; then
  log "Running default Terratest suite"
  (cd "11-terratest/test" && go test -v -timeout 5m)
fi

if [[ "$run_apply" -eq 1 ]]; then
  log "Applying and destroying preview hands-on roots against miniblue"
  echo "This requires miniblue to be running and its certificate to be trusted."

  curl -fsS http://localhost:4566/health >/dev/null

  for root in "${apply_roots[@]}"; do
    log "Apply/destroy: $root"
    terraform -chdir="$root" init -backend=false -input=false

    case "$root" in
      "03-for-each-patterns")
        terraform -chdir="$root" apply -input=false -auto-approve -var-file="$tmp_dir/03-for-each-patterns.tfvars"
        terraform -chdir="$root" destroy -input=false -auto-approve -var-file="$tmp_dir/03-for-each-patterns.tfvars"
        ;;
      "04-dynamic-patterns")
        terraform -chdir="$root" apply -input=false -auto-approve -var-file="$tmp_dir/04-dynamic-patterns.tfvars"
        terraform -chdir="$root" destroy -input=false -auto-approve -var-file="$tmp_dir/04-dynamic-patterns.tfvars"
        ;;
      *)
        terraform -chdir="$root" apply -input=false -auto-approve
        terraform -chdir="$root" destroy -input=false -auto-approve
        ;;
    esac
  done
fi

log "Preview smoke checks completed"
