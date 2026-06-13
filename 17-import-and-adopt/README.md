# Lab 17 - Import And Adopt Existing Infrastructure

## What this lab teaches you

This lab teaches how to bring existing infrastructure under Terraform management without recreating it.

You will learn:

- why import is a state operation
- why import does not generate perfect configuration for you
- how to write matching Terraform configuration
- how to converge to a clean plan after import
- how to explain adoption risk before touching production resources

## Scenario

Your team has a small Azure resource group that was created outside Terraform.

It works, but now the team wants it managed through the same Terraform workflow as the rest of the platform. Your job is to adopt it safely.

In this local-first course, you will create the existing resources out-of-band with `azlocal`, then import them into Terraform.

## What this lab adopts

This lab adopts one resource group.

The Terraform configuration in this folder describes the desired final state. The resources must already exist before you import them.

## Prerequisites

- Complete `00-bootstrap`.
- Start `miniblue`.
- Trust the local `miniblue` certificate if your machine requires it.
- Confirm:

```bash
curl -s http://localhost:4566/health
```

## Step 1 - Create Resources Out Of Band

Run these commands from any directory:

```bash
azlocal group create \
  --name tf-course-adopt-rg \
  --location eastus \
  --tags Environment=dev ManagedBy=manual Stack=tf-course Adoption=lab17
```

These resources now exist, but Terraform does not know about them.

## Step 2 - Initialize Terraform

From this lab directory:

```bash
terraform init
terraform validate
```

## Step 3 - Predict The Plan Before Import

Run:

```bash
terraform plan
```

Expected:

- Terraform wants to create the resource group.

That plan is dangerous if the resources already exist. Do not apply it.

## Step 4 - Import The Existing Resources

Import the resource group:

```bash
terraform import \
  azurerm_resource_group.adopted \
  /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/tf-course-adopt-rg
```

## Step 5 - Converge Configuration

Run:

```bash
terraform plan
```

You may see tag changes because this Terraform configuration converges the resource to the course tagging standard, including `ManagedBy=terraform`.

That is expected.

Read the plan carefully. It should update metadata, not destroy and recreate the resources.

Apply only after you confirm there is no unexpected replacement:

```bash
terraform apply
```

Then confirm the plan is clean:

```bash
terraform plan
```

## Step 6 - Inspect State

Run:

```bash
terraform state list
terraform state show azurerm_resource_group.adopted
```

Answer:

- Which Terraform addresses now manage the existing resources?
- Which remote IDs are stored in state?
- Which attributes came from configuration?
- Which attributes came from the provider after import?

## Cleanup

Because Terraform now manages the adopted resources, clean up with:

```bash
terraform destroy
```

If import failed before Terraform took ownership, clean up with:

```bash
azlocal group delete --name tf-course-adopt-rg
```

## Deliverable

Write a short adoption note with:

- the out-of-band commands used to create the resources
- the import commands used
- the first post-import plan summary
- whether Terraform planned updates, replacements, or no changes
- the final clean-plan result

## Success Criteria

You are done when you can explain:

- why `terraform import` changes state but does not create configuration
- why you must write matching configuration before import
- why a post-import plan may still show safe updates
- how to distinguish adoption from drift correction
- why you should never apply a create plan over resources you intend to import
