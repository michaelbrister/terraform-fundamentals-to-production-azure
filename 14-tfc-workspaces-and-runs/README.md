# Lab 14 - Terraform Cloud Workspaces And Runs

## What this lab teaches you

This lab teaches the team workflow concepts behind Terraform Cloud without requiring a Terraform Cloud account.

You will learn:

- what a workspace is
- what a run is
- how speculative plans differ from applies
- how GitHub Actions can model the same control points for this course
- where approvals belong in a team Terraform workflow

## Why this matters

Solo Terraform is mostly about running commands correctly.

Team Terraform is about making changes reviewable, repeatable, and controlled. A healthy team workflow answers:

- Who proposed the change?
- What will Terraform change?
- Who reviewed the plan?
- Who is allowed to apply?
- Where can we find the audit trail later?

Terraform Cloud answers those questions with workspaces, runs, teams, policies, and approvals. This local-first course models the same ideas with folders, CI jobs, branch protection, and optional GitHub environments.

## Concept mapping

| Terraform Cloud concept | Local/GitHub equivalent in this repo |
| --- | --- |
| Workspace | `live/dev`, `live/stage`, `live/prod` root modules |
| Speculative plan | Pull request CI running `terraform init`, `fmt`, `validate`, and optional `plan` |
| Run | One CI workflow execution |
| Apply gate | Manual approval before applying to shared environments |
| Workspace variables | Environment-specific variables and secrets |
| Policy set | OPA/Conftest checks in `policy/` |
| Run history | GitHub Actions run history |

## Current repo workflow

The public preview CI currently runs:

```bash
bash scripts/preview-smoke.sh --skip-go
```

That script checks:

- formatting for valid Terraform roots
- initialization and validation for valid Terraform roots
- intentional failure scenarios
- provider version drill initialization

The Go job separately runs the default Terratest suite.

## Exercise 1 - Read The CI As A Run Pipeline

Open:

```bash
.github/workflows/ci.yml
scripts/preview-smoke.sh
```

Answer:

- Which job acts like a speculative Terraform run?
- Which command prevents interactive prompts?
- Which failures are intentional course exercises?
- Why does CI avoid live `apply` against `miniblue`?

## Exercise 2 - Map Folders To Workspaces

Inspect:

```bash
live/dev
live/stage
live/prod
```

Answer:

- Which settings vary by environment?
- Which module source stays the same?
- Which environment would need the strictest approval gate?
- Why is folder-per-environment easier for a local-first tutorial than remote workspaces?

## Exercise 3 - Design An Apply Gate

Sketch an apply workflow for `live/prod`.

Minimum requirements:

- Pull request must pass CI.
- Plan output must be reviewed before apply.
- Apply must be manually approved.
- Production apply must be limited to maintainers.
- The workflow history must show who approved and when.

You do not need to implement the workflow in this lab. The goal is to explain the control points before automating them.

## Optional GitHub Environment Exercise

If this repo is hosted on GitHub:

1. Create an environment named `prod-apply`.
2. Require a reviewer for that environment.
3. Draft a future workflow job that targets `environment: prod-apply`.
4. Explain how that approval pause maps to Terraform Cloud apply approvals.

## Deliverable

Write a short note with:

- one paragraph explaining Terraform Cloud workspaces and runs
- one table mapping this repo's local-first workflow to Terraform Cloud
- one proposed approval flow for `live/prod`

## Success criteria

You are done when you can explain:

- why plan and apply should be separate team events
- why CI should run on every pull request
- why production applies need stronger controls than dev applies
- how this local-first repo can later move to Terraform Cloud without changing the learning model

