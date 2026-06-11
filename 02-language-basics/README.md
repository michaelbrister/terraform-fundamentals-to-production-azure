# Lab 02 — Terraform Language Basics (Variables, Locals, Outputs)

## What this lab teaches you

This lab focuses on the Terraform language itself.

You will learn:

- input variables and defaults
- type constraints and validation
- locals for reuse and clarity
- outputs as the public interface of a configuration

## Mental model

Terraform is declarative.

You do not write steps like:

1. create a resource group
2. then tag it

Instead, you describe the desired end state and Terraform calculates the actions needed to reach it.

## Variables in this lab

This lab uses:

- `env`
- `location`
- `workload_name`

These values control naming and tags without changing the structure of the configuration.

## Locals in this lab

This configuration uses locals to:

- build a reusable name prefix
- centralize common tags

That reduces duplication and makes the configuration easier to read.

## Predict the plan

Before running `terraform plan`, answer:

1. What value will `var.env` have?
2. What resource group name will Terraform build from the local values?
3. If you change `workload_name`, will Terraform update or replace the resource group?

## Workflow

Run:

```bash
terraform fmt
terraform init
terraform validate
terraform plan
```

Observe:

- how variables affect names and tags
- how locals expand into concrete values
- how outputs expose selected values

## Exercises

### Exercise 1 — Override a variable via CLI

```bash
terraform plan -var="env=stage"
```

Predict the resource group name before you run it.

### Exercise 2 — Override via `terraform.tfvars`

Create a `terraform.tfvars` file:

```hcl
env           = "prod"
workload_name = "payments"
```

Then run:

```bash
terraform plan
```

### Exercise 3 — Change a local effect indirectly

Change `workload_name` and observe how the resource name and tags change together.

## Exam notes

Pay attention to:

- variable precedence
- when locals are better than more variables
- how outputs act like return values

## Cleanup

```bash
terraform destroy -auto-approve
```
