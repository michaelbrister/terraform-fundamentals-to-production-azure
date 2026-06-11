# Lab 13 — Terraform State Subcommands

## What this lab teaches you

This lab teaches how to inspect and manipulate Terraform state directly.

You will practice:

- `terraform state list`
- `terraform state show`
- `terraform state mv`
- `terraform state rm`

## Warning

State commands change Terraform's memory.

They do not change real infrastructure directly, but incorrect state changes can make future plans dangerous.

Use them deliberately.

## Mental model

Terraform state maps resource addresses to real infrastructure.

Example:

```text
azurerm_resource_group.a
```

means Terraform believes the resource block named `a` corresponds to one real resource group.

## Setup

Start `miniblue`, then run:

```bash
terraform init
terraform apply -auto-approve
```

This creates two resource groups.

## Inspect state

List tracked addresses:

```bash
terraform state list
```

Show one tracked resource:

```bash
terraform state show azurerm_resource_group.a
```

## Mini-drill 1 — Rename with state mv

Rename this block in `main.tf`:

```hcl
resource "azurerm_resource_group" "a"
```

to:

```hcl
resource "azurerm_resource_group" "primary"
```

Run:

```bash
terraform plan
```

Terraform should no longer see the old address.

Fix state alignment:

```bash
terraform state mv \
  azurerm_resource_group.a \
  azurerm_resource_group.primary
```

Then run:

```bash
terraform plan
```

The plan should avoid destroy/create caused by the rename.

## Mini-drill 2 — Remove from state

Remove `b` from state without destroying it:

```bash
terraform state rm azurerm_resource_group.b
```

Now run:

```bash
terraform plan
```

Terraform should want to create `b` again, because it forgot that the real resource already exists.

This is why `state rm` is powerful and risky.

## Recovery discussion

To restore management after `state rm`, you can either:

- import the existing resource group again
- restore state from backup if this was a mistake

Import example:

```bash
terraform import \
  azurerm_resource_group.b \
  /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/tf-course-state-b-rg
```

## Cleanup

Only destroy once state and configuration agree:

```bash
terraform destroy -auto-approve
```

## Key takeaways

- `state list` shows Terraform addresses
- `state show` shows Terraform's remembered attributes
- `state mv` changes identity without changing infrastructure
- `state rm` makes Terraform forget a resource
- clean plans are the proof that state and config agree
