# Drill 09 — Provider Version Conflict

**Timebox:** 10 minutes

## Prompt

The course uses `azurerm ~> 3.0`, but this drill pins `~> 2.0`.

## Tasks

1. Run `terraform init`.
2. Identify what version Terraform selects.
3. Explain why version constraints matter.
4. Update the constraint to match the course provider series.

## Success answer

Provider constraints should be deliberate and consistent. Lockfiles record selections, but constraints define what Terraform is allowed to select.
