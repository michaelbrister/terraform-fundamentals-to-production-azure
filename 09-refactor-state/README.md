# Lab 09 — Refactoring Terraform State Safely

## What this lab teaches you

This lab teaches how to change Terraform code without accidentally replacing infrastructure.

You will learn:

- why resource addresses define Terraform identity
- how a code-only rename can produce a dangerous plan
- how `moved` blocks preserve identity
- how `terraform state mv` changes Terraform's memory without changing infrastructure
- how `terraform import` adopts existing resources

## Mental model

Terraform does not decide what a resource is from the cloud resource name alone.

Terraform tracks identity through the resource address stored in state.

For example:

```text
azurerm_resource_group.oldname
```

and:

```text
azurerm_resource_group.newname
```

are different Terraform addresses, even if both blocks use the same Azure resource group name.

## Why this matters

Many risky Terraform changes are not "new infrastructure" changes. They are refactors:

- renaming a resource block
- moving a resource into a module
- changing a `for_each` key
- reorganizing files

If Terraform state is not updated to match the new address, Terraform may plan to destroy and recreate infrastructure.

## Lab structure

This lab is split into five small directories:

- `step1` establishes a baseline resource
- `step2` shows the dangerous code-only rename
- `step3` shows the `terraform state mv` recovery workflow
- `step4` shows a `moved` block for moving into a module
- `step5` shows import of existing infrastructure

The examples use Azure resource groups because they are simple and validated on `miniblue`.

## Rules for this lab

- Read every plan before applying
- Never apply a plan that unexpectedly destroys resources
- Treat `terraform state mv` and `terraform import` as deliberate state operations
- End every refactor with a clean plan

## Key takeaways

- Terraform identity lives in state
- Code refactors can look like infrastructure replacement unless state is updated
- `moved` blocks are preferred when the move can be described in code
- `terraform state mv` is useful for manual, deliberate state changes
- `terraform import` adopts existing infrastructure; it does not create it
