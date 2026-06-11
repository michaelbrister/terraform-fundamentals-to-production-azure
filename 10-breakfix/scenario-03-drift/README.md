# Scenario 03 — Drift

## Goal

Recognize when reality changed outside Terraform and choose a safe reconciliation path.

## Baseline

Run:

```bash
terraform init
terraform apply -auto-approve
terraform plan
```

The final plan should be clean.

## Introduce drift

Change the resource group outside Terraform:

```bash
azlocal group create --name tf-course-drift-rg --location eastus --tags Owner=manual
```

Then run:

```bash
terraform plan
```

## What to inspect

Ask:

1. What does config want?
2. What does state say?
3. What exists in `miniblue`?
4. Is the drift acceptable or should Terraform revert it?

## Fix rubric

Choose one path:

- Revert drift by applying Terraform's desired tags
- Accept drift by updating configuration to match reality

## Success checkpoint

You are done when the plan is clean and you can explain which source of truth won.
