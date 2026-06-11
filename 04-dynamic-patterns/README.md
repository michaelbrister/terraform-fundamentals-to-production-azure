# Lab 04 — Dynamic Blocks and Optional Configuration

## What this lab teaches you

This lab teaches you how Terraform can build repeated nested blocks using `dynamic`.

You will learn:

- what a `dynamic` block is
- how Terraform expands nested blocks during planning
- how one input structure can generate zero, one, or many nested rule blocks

## Why this matters

Many real Terraform resources contain nested configuration blocks.

In Azure networking, security rules are a good example:

- one NSG may have many rules
- each rule has a repeated nested structure

This makes NSGs a good fit for learning `dynamic`.

## Mental model

`dynamic` is not a loop that runs step by step.

Terraform:

1. evaluates the input expressions
2. expands the nested block structure
3. compares the resulting structure to state

So a `dynamic` block is best understood as a template that expands into real nested blocks.

## What this lab creates

This lab creates:

- one shared resource group
- one or more network security groups
- a `security_rule` block for each rule object you provide

## Predict the plan

Before you run `terraform plan`, answer:

1. How many NSGs will be created?
2. How many `security_rule` blocks will Terraform generate for each NSG?
3. If you add one rule to a list, should Terraform add one nested block or replace the entire resource?

## Workflow

Run:

```bash
terraform fmt
terraform init
terraform validate
terraform plan
```

## Suggested input

Create a `terraform.tfvars` file:

```hcl
security_groups = {
  web = {
    rules = [
      {
        name                       = "allow-https-in"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "allow-http-in"
        priority                   = 110
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }
}
```

## Exercises

### Exercise 1 — Add another nested block

Add a third rule and run:

```bash
terraform plan
```

Observe how Terraform adds one more `security_rule` block.

### Exercise 2 — Remove a rule

Remove one rule from the list and confirm Terraform plans to remove only that nested rule configuration.

### Exercise 3 — Add a second NSG

Add another key under `security_groups` and observe how Terraform combines `for_each` at the resource level with `dynamic` inside the resource.

## Common mistakes

- using `dynamic` when a normal argument is enough
- confusing resource-level repetition with nested-block repetition
- making input objects harder to read than the resource itself

## Key takeaways

- use `for_each` to create multiple resources
- use `dynamic` to create repeated nested blocks inside a resource
- predict the final expanded structure before you apply

## Cleanup

```bash
terraform destroy -auto-approve
```
