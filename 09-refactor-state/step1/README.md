# Step 1 — Establish a Safe Baseline

## Goal

Create one resource group and confirm Terraform state is trustworthy before refactoring.

## Commands

```bash
terraform init
terraform plan
terraform apply -auto-approve
terraform plan
```

The final plan should be clean.

## Resource address

The baseline address is:

```text
azurerm_resource_group.oldname
```

That address is Terraform's identity for the resource.

## Checkpoint

Continue only when:

- the resource exists
- state exists
- `terraform plan` shows no changes
- you can identify the resource address
