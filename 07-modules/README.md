# Lab 07 — Terraform Modules (Reuse, Interfaces, and Boundaries)

## What this lab teaches you

This lab teaches one of the most important structural concepts in Terraform:

> Modules are how Terraform scales safely.

You will learn:

- what a Terraform module is
- how inputs and outputs form a contract
- how modules create reuse without copy and paste
- how modules help define boundaries between callers and implementation details

## Mental model

A Terraform module is like a function:

- inputs are parameters
- outputs are return values
- the module internals are implementation details
- the caller should care about the contract, not every internal resource

## Why modules matter

Without modules, infrastructure code tends to become:

- duplicated
- inconsistent
- harder to change safely

Modules give you one reusable definition that multiple callers can use with different inputs.

## Module structure in this lab

This lab uses:

```text
modules/
  app_stack/
    main.tf
    variables.tf
    outputs.tf
```

The module creates reusable Azure network-building blocks:

- resource groups
- virtual networks
- subnets
- optional network security groups

## What belongs inside the module

Good module contents:

- reusable infrastructure patterns
- resources that naturally belong together
- logic shared across environments

Things that should stay outside the module:

- backend configuration
- credentials
- one-off environment decisions

## What this caller does

The root lab calls the module once and passes:

- `env`
- `name_prefix`
- `location`
- `network_stacks`

That input map defines two logical stacks:

- `app`
- `data`

The `app` stack also enables an NSG with a rule list.

## Predict the plan

Before running `terraform plan`, answer:

1. How many resource groups will the module create?
2. How many VNets and subnets will it create?
3. Which stack gets an NSG?
4. If you add another subnet under `app`, does Terraform need another module block, or just another input value?

## Workflow

Run:

```bash
terraform fmt
terraform init
terraform validate
terraform plan
```

Observe:

- how module paths appear in the plan
- how caller inputs shape internal resources
- how outputs expose selected values back to the root module

## Guided exercises

### Exercise 1 — Add a new subnet

Add another subnet under `network_stacks.app.subnets`.

Predict:

- which resource address will be added
- whether anything existing should be replaced

### Exercise 2 — Add another stack

Add a `shared` stack with its own address space and subnet.

Predict how many resources the module will add.

### Exercise 3 — Add a new output

Expose another useful value from `modules/app_stack/outputs.tf`.

Predict:

- does this change infrastructure
- or only Terraform outputs

## Common mistakes

- putting environment-specific behavior deep inside the module
- exposing more outputs than callers actually need
- treating modules as magic rather than normal Terraform with a boundary

## Key takeaways

- modules are reusable interfaces, not just folders
- inputs and outputs are the module contract
- callers configure behavior without needing to duplicate implementation
- the same module can support multiple environments and stacks

## Validation note

This module intentionally stays within the `miniblue`-validated Azure resource set used earlier in the course.

## Cleanup

```bash
terraform destroy -auto-approve
```
