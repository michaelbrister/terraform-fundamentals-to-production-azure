# Scenario 04 — Locks and Partial Operations

## Goal

Practice the recovery mindset for interrupted or concurrent Terraform operations.

## Why this matters

Locks protect state from concurrent writes.

Even with local state, the habit matters:

- identify whether another run is active
- avoid deleting state files
- use `force-unlock` only when you are certain a lock is stale

## Actions

In one terminal:

```bash
terraform init
terraform apply
```

Before approving, open a second terminal and run:

```bash
terraform plan
```

Observe how Terraform behaves when another operation is active or waiting.

## Partial operation drill

If an apply is interrupted, do not panic.

Run:

```bash
terraform state list
terraform plan
```

Then decide whether configuration, state, or reality needs action.

## What must not happen

- Do not delete `terraform.tfstate`
- Do not blindly run apply repeatedly
- Do not force-unlock unless you know no run is active

## Success checkpoint

You are done when you can explain the next safe action after an interrupted run.
