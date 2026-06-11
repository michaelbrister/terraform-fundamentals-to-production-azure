# Lab 08 — Terraform Console (Expressions, Types, and Debugging)

## What this lab teaches you

This lab teaches you how to use Terraform Console as a learning and debugging tool.

Terraform Console lets you:

- evaluate expressions without applying infrastructure
- inspect types and values
- understand how Terraform interprets your configuration
- experiment safely without changing state

## Why this matters

Console mastery makes Terraform feel much less mysterious.

When a `for` expression, optional value, or complex object feels confusing, Terraform Console gives you a safe place to inspect it directly.

## Mental model

Terraform Console is a calculator for Terraform expressions.

It reads your configuration and evaluates expressions the same way Terraform would during planning.

It does not create, change, or destroy infrastructure.

## Starting the console

From this directory:

```bash
terraform init
terraform console
```

You will see:

```text
>
```

Everything you type after that prompt is a Terraform expression.

## Inspecting values and types

Try:

```hcl
var.env
type(var.env)
var.subnets
type(var.subnets)
```

Terraform is strongly typed. Understanding the type often explains the error.

## Working with objects and maps

Try:

```hcl
var.network_stacks
keys(var.network_stacks)
var.network_stacks["app"].address_space
```

Predict the type before running each expression.

## For expressions

Try:

```hcl
[for subnet in var.subnets : subnet.name]
[for subnet in var.subnets : "${var.prefix}-${var.env}-${subnet.name}"]
{ for name, stack in var.network_stacks : name => stack.address_space }
```

These are the same expression patterns used in modules and production Terraform.

## Filtering

Try:

```hcl
[for subnet in var.subnets : subnet.name if subnet.tier == "web"]
{ for name, stack in var.network_stacks : name => stack if stack.create_nsg }
local.nsg_enabled_stacks
```

Filtering is the foundation of patterns like "only create this resource for these inputs."

## Grouping

Try:

```hcl
local.subnets_by_zone
local.subnets_by_tier
```

These locals transform a flat subnet list into lookup-friendly maps.

## Safe access with `lookup`, `try`, and `can`

Try:

```hcl
lookup(local.tags_common, "Owner", "unassigned")
try(var.maybe.missing, null)
can(var.maybe.missing)
```

These functions help you handle optional or missing data without making a plan fail unexpectedly.

## Predict before running

For each expression:

1. predict the type
2. predict the value
3. run the expression
4. compare the result to your prediction

This habit is excellent practice for both real work and Terraform Associate questions.

## Key takeaways

- Terraform Console is safe for expression debugging
- types matter
- `for` expressions transform collections
- `if` filters collections
- `try`, `can`, and `lookup` help with optional data
