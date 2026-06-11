# Drill 01 — Backend Initialization Failure

**Timebox:** 10 minutes

## Prompt

Terraform cannot initialize a remote Azure backend.

You are given this conceptual backend shape:

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "tf-course-backend-rg"
    storage_account_name = "tfcoursebackend001"
    container_name       = "tfstate"
    key                  = "dev/terraform.tfstate"
  }
}
```

## Questions

1. What must exist before `terraform init` can succeed?
2. Does Terraform create backend resources from this block?
3. What provides locking in the Azure backend?
4. Why is this drill concept-first in the `miniblue` edition?

## Expected answer

- The resource group, storage account, and blob container must already exist.
- The backend block configures Terraform; it does not create resources.
- Azure Storage blob leases provide locking.
- `miniblue` does not currently support Terraform's standard `azurerm` backend path as a drop-in local backend.
