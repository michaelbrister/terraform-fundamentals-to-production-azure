# Lab 15 - Team RBAC And Variable Governance

## What this lab teaches you

This lab teaches how teams control who can do what and how shared variables should be managed.

You will learn:

- the difference between plan, apply, admin, and audit responsibilities
- how variable precedence works
- how environment-specific configuration maps to Terraform Cloud variable sets
- how Azure RBAC concepts fit into Terraform workflows
- why secrets should not live in committed `.tfvars` files

## Why this matters

Most production Terraform mistakes are not syntax problems. They are workflow problems:

- too many people can apply to production
- secrets are copied into code
- dev and prod variables drift without review
- nobody knows which variable source won
- a plan is approved by someone who does not understand the blast radius

This lab gives you a team vocabulary before you wire up real platforms.

## Role model

| Responsibility | Terraform Cloud role idea | GitHub/local-first equivalent |
| --- | --- | --- |
| Read plans | Viewer | Pull request reader |
| Propose changes | Plan-capable contributor | Branch author |
| Approve applies | Apply-capable maintainer | GitHub environment reviewer |
| Manage variables | Workspace admin | Repo maintainer or secrets admin |
| Review audit history | Auditor | Actions and pull request reviewer |

## Azure RBAC model

Real Azure adds another permission layer.

For production, a Terraform service principal or workload identity should usually have only the permissions needed for the managed scope. For this course, `miniblue` uses local fake credentials, but the workflow lesson is the same:

- humans review code and plans
- automation performs applies
- production credentials are more protected than dev credentials
- broad owner-style access should be rare and temporary

## Variable sources

Terraform can receive values from several places.

Common precedence path for this course:

1. variable defaults in `variables.tf`
2. values in `.tfvars` files
3. environment variables like `TF_VAR_owner`
4. command-line `-var` or `-var-file`

When teaching teams, the important habit is not memorizing every precedence rule. The habit is making variable ownership obvious.

## Exercise 1 - Inspect Environment Differences

Open:

```bash
live/dev/main.tf
live/stage/main.tf
live/prod/main.tf
```

Answer:

- Which values are environment-specific?
- Which values should be shared across all environments?
- Which values would become Terraform Cloud workspace variables?
- Which values would become secrets?

## Exercise 2 - Propose Variable Governance

Create a short table for these values:

| Value | Source | Who owns it? | Secret? |
| --- | --- | --- | --- |
| `env` | root module | platform team | no |
| `name_prefix` | shared variable set | platform team | no |
| `location` | shared variable set | platform team | no |
| Azure client secret | secret variable | platform/security team | yes |
| approval reviewers | GitHub/TFC setting | repo maintainers | no |

Add at least three more values from the `live/*` folders.

## Exercise 3 - Demonstrate Variable Override Locally

Pick a simple lab with a safe variable, such as `02-language-basics`.

Run:

```bash
terraform init -backend=false
terraform plan
TF_VAR_env=stage terraform plan
```

Answer:

- Which value changed?
- Did the resource address change?
- Would this be safe to do casually in a shared environment?

## Exercise 4 - Design Production Access

Design a production access model.

Your model should answer:

- Who can open a pull request?
- Who can approve a pull request?
- Who can approve a production apply?
- Where are Azure credentials stored?
- Who can rotate credentials?
- What evidence proves a production change was approved?

## Deliverable

Write a team governance note with:

- an RBAC table
- a variable ownership table
- one paragraph explaining how `miniblue` credentials differ from real Azure credentials
- one paragraph explaining how your team would protect `live/prod`

## Success criteria

You are done when you can explain:

- why plan permission and apply permission are different
- how Terraform variables can be governed by ownership and sensitivity
- why real Azure credentials belong in secret storage, not Git
- how this repo's local pattern maps to Terraform Cloud workspace variables

