# Scenario 01 — Configuration Parse Error

## Goal

Practice stopping at the first configuration error.

## What is intentionally broken

`main.tf` contains a malformed tags map. Terraform should fail before it can plan.

## First, predict

Before running anything, answer:

1. Will Terraform reach the planning phase?
2. Will it touch state?
3. Is this a configuration, state, or reality problem?

## Actions

Run:

```bash
terraform init
terraform validate
```

## Fix rubric

Fix the tags map by adding the missing separator:

```hcl
tags = {
  Lab      = "10"
  Scenario = "parse-error"
}
```

Then run:

```bash
terraform fmt
terraform validate
terraform plan
```

## Success checkpoint

You are done when Terraform reaches the planning phase and you can explain why no infrastructure or state action was needed.
