# Step 2 — Change Code Only

## Goal

See why a code-only rename is dangerous when state still contains the old address.

## What changed

The Terraform resource block was renamed from:

```text
azurerm_resource_group.oldname
```

to:

```text
azurerm_resource_group.newname
```

The Azure resource group name stayed the same.

## Commands

Run only:

```bash
terraform init
terraform plan
```

Do not apply this plan.

## What to look for

Terraform should treat the old address and new address as different identities.

That is the lesson: the cloud resource name is not enough to preserve Terraform identity.

## Checkpoint

Continue only when you can explain:

- why Terraform no longer sees the old address in configuration
- why Terraform thinks the new address is a new object
- why applying a destroy/create plan during a refactor is risky
