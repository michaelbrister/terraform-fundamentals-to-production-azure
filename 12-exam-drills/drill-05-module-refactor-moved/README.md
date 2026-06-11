# Drill 05 — Module Refactor with moved Blocks

**Timebox:** 15 minutes

## Prompt

A resource moved from a root resource block into a module.

Old address:

```text
azurerm_resource_group.example
```

New address:

```text
module.resource_group.azurerm_resource_group.this
```

## Tasks

1. Write the `moved` block.
2. Explain what changes in state.
3. Explain what must not change in reality.

## Success answer

```hcl
moved {
  from = azurerm_resource_group.example
  to   = module.resource_group.azurerm_resource_group.this
}
```

The refactor is successful when the plan shows no replacement.
