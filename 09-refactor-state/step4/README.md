# Step 4 — Move a Resource Into a Module

## Goal

Use a `moved` block to describe a refactor in code.

## What changed

The resource moved from a root address:

```text
azurerm_resource_group.newname
```

to a module address:

```text
module.resource_group.azurerm_resource_group.this
```

## Commands

```bash
terraform init
terraform plan
```

If the plan does not propose replacement, apply:

```bash
terraform apply -auto-approve
```

## Why `moved` blocks matter

A `moved` block makes the refactor reviewable in code.

It tells Terraform:

```text
this old address and this new address are the same object
```

## Checkpoint

Continue only when:

- Terraform accepts the `moved` block
- no replacement is proposed
- you can explain the old and new addresses
