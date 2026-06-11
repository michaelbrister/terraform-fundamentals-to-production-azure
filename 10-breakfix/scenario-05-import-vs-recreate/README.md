# Scenario 05 — Import vs Recreate

## Goal

Adopt existing infrastructure instead of trying to recreate it.

## Create infrastructure out of band

```bash
azlocal group create --name tf-course-adopt-rg --location eastus
```

At this point:

- reality has a resource group
- configuration has a matching resource block
- state does not connect them

## Import

Run:

```bash
terraform init
terraform import \
  azurerm_resource_group.adopt \
  /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/tf-course-adopt-rg
```

Then run:

```bash
terraform plan
```

## What to look for

Import changes state only.

The first post-import plan may show tag convergence because the out-of-band resource was created without Terraform's tags.

## Success checkpoint

You are done when:

- Terraform state tracks the resource
- no recreate is required
- configuration and reality converge intentionally
