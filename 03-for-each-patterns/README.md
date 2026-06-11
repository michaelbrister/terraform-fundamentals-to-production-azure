# Lab 03 — `for_each` Patterns and Stable Resource Addressing

## What this lab teaches you

This lab teaches how to scale resources safely using `for_each` instead of copy and paste.

You will learn:

- `for_each` with maps
- stable identity through keys
- filtered `for_each` expressions

## The core problem

If you need multiple similar network stacks, copying resource blocks does not scale.

Terraform gives you looping patterns, but the important question is not quantity.

It is identity.

Terraform tracks resources by address, and `for_each` gives each resource a stable key-based address.

## What this lab creates

For each stack in `var.network_stacks`, Terraform creates:

- one resource group
- one virtual network

For stacks with `create_nsg = true`, Terraform also creates:

- one network security group

## Why this matters

When keys stay stable:

- reordering your map does not cause replacement
- adding one stack adds one stack
- removing one stack destroys only that stack

## Predict the plan

Before running `terraform plan`, answer:

1. Which keys will exist in the resource addresses?
2. Which stacks will get NSGs?
3. If you add a new key, how many resources should be added?

## Workflow

Run:

```bash
terraform fmt
terraform init
terraform validate
terraform plan
```

## Exercises

### Exercise 1 — Add a new stack

Add another map key and run:

```bash
terraform plan
```

Expected:

- one new resource group
- one new virtual network
- maybe one new NSG, depending on `create_nsg`

### Exercise 2 — Remove a stack

Remove one key and confirm only that stack is destroyed.

### Exercise 3 — Reorder keys

Reorder the map entries and confirm Terraform shows no changes.

## Suggested input

Use a `terraform.tfvars` file like:

```hcl
network_stacks = {
  app = {
    create_nsg    = true
    address_space = ["10.10.0.0/16"]
    tags          = { Purpose = "app" }
  }
  data = {
    create_nsg    = false
    address_space = ["10.20.0.0/16"]
    tags          = { Purpose = "data" }
  }
}
```

## Key takeaways

- Terraform tracks identity, not quantity
- `for_each` keys become part of the resource address
- filtered `for_each` is a clean way to create only some related resources

## Cleanup

```bash
terraform destroy -auto-approve
```
