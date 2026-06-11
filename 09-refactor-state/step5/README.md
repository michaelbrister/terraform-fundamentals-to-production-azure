# Step 5 — Import Existing Infrastructure

## Goal

Adopt an existing resource group into Terraform state without recreating it.

## Create infrastructure outside Terraform

With `miniblue` running:

```bash
azlocal group create --name tf-course-import-me-rg --location eastus
```

At this point:

- the resource group exists
- Terraform configuration exists
- Terraform state does not know they belong together

## Import it

Run:

```bash
terraform init
terraform import \
  azurerm_resource_group.import_me \
  /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/tf-course-import-me-rg
```

Then run:

```bash
terraform plan
```

## Expected result

The import itself should not create infrastructure.

The first plan after import may show tag updates if the out-of-band resource did not have matching tags. That is normal: import connects identity; configuration convergence is the next step.

## What import means

`terraform import` changes state.

It tells Terraform:

```text
this real resource belongs to this resource address
```

## Key takeaways

- import adopts infrastructure; it does not create it
- import and refactor workflows are both about state alignment
- a clean plan is the final proof that configuration, state, and reality agree
