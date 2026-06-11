# Drill 02 — Count to for_each Without Recreation

**Timebox:** 15 minutes

## Prompt

This config uses `count` with a list. Reordering `var.names` can create replacement plans.

## Tasks

1. Identify the resource addresses Terraform will create.
2. Explain why list order affects identity.
3. Rewrite the resource with `for_each = toset(var.names)`.
4. Describe the `terraform state mv` commands required to preserve existing resources.

## Do not apply

If Terraform proposes replacements after a reorder, stop and explain why.

## Success answer

`count` addresses look like `azurerm_resource_group.example[0]`. `for_each` addresses look like `azurerm_resource_group.example["alpha"]`. Stable keys survive list reordering.
