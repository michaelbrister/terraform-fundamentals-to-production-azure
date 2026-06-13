# Self-Paced Syllabus

This path is designed for learners who want to complete the Azure edition without creating an Azure account at the start.

The preview track uses `miniblue` for local Azure-style resources where possible. Labs `05` and `06` are concept-first because the fully local `backend "azurerm"` path is not yet proven against `miniblue`.

## Week 0 - Orientation

Time: 2-3 hours

Do:

- Read the top-level `README.md`.
- Complete `00-bootstrap`.
- Confirm Terraform can talk to local `miniblue`.
- Read `docs/miniblue-validation.md`.

Outcomes:

- Explain why the course starts local-first.
- Identify which labs are hands-on and which are concept-first.
- Know how to start, stop, and verify the local emulator.

## Week 1 - Core Terraform Workflow

Labs:

- `01-local-basics`
- `02-language-basics`

Outcomes:

- Run `terraform init`, `validate`, `plan`, `apply`, and `destroy`.
- Explain the relationship between configuration, state, and real infrastructure.
- Use variables, locals, outputs, and tags to shape repeatable configuration.

Checkpoint:

- Before applying, say what Terraform should create and why.

## Week 2 - Collections And Stable Identity

Labs:

- `03-for-each-patterns`
- `08-terraform-console`

Outcomes:

- Explain why stable map keys are safer than positional lists for long-lived resources.
- Use `terraform console` to test expressions before putting them in configuration.
- Predict how a key rename affects state.

Checkpoint:

- Change one map value without changing its key and confirm Terraform plans an update rather than replacement.

## Week 3 - Optional Nested Configuration

Lab:

- `04-dynamic-patterns`

Outcomes:

- Use dynamic blocks for optional nested Azure resource configuration.
- Explain when dynamic blocks improve clarity and when they hide too much complexity.
- Keep input object shapes readable for future maintainers.

Checkpoint:

- Add, update, and remove a security rule and predict the plan each time.

## Week 4 - State, Backends, And Migration

Labs:

- `05-backend-bootstrap`
- `06-state-migration`
- `13-state-subcommands`

Outcomes:

- Explain why shared state and locking matter on teams.
- Describe the Azure Storage backend shape: storage account, container, key, and lock behavior.
- Use state inspection and safe state operations without treating state as a mystery box.

Checkpoint:

- Explain the difference between moving a resource in configuration and moving a resource address in state.

## Week 5 - Modules And Refactors

Labs:

- `07-modules`
- `09-refactor-state`

Outcomes:

- Build and consume a small Azure module.
- Design module inputs and outputs that are useful but not overly coupled.
- Refactor with `moved` blocks and state-aware workflows.

Checkpoint:

- Refactor one resource address without replacing the resource.

## Week 6 - Troubleshooting And Test Discipline

Labs:

- `10-breakfix`
- `11-terratest`
- `12-exam-drills`

Outcomes:

- Diagnose parse errors, identity instability, drift, partial operations, and import-vs-recreate decisions.
- Run the default Terratest suite.
- Use timed drills to build exam-style Terraform fluency.

Checkpoint:

- Pick one failed scenario, explain the root cause, fix it, and rerun validation.

## Week 7 - Environment Structure

Labs:

- `live/dev`
- `live/stage`
- `live/prod`

Outcomes:

- Compare folder-per-environment configuration.
- Understand how a shared module can support different environment settings.
- Explain what should and should not vary between dev, stage, and prod.

Checkpoint:

- Predict the differences in plan output between `dev`, `stage`, and `prod`.

## Week 8 - Team Workflow And Governance

Labs:

- `14-tfc-workspaces-and-runs`
- `15-team-rbac-and-variables`
- `16-governance-sentinel-opa-and-approvals`

Outcomes:

- Map Terraform Cloud workspaces and runs to this repo's local/GitHub workflow.
- Explain plan/apply separation and production approvals.
- Describe team RBAC, variable ownership, and secret handling.
- Read OPA policy examples and explain how they map to Sentinel policy sets.

Checkpoint:

- Write a short governance note for `live/prod` that includes CI, policy, approval, and credential ownership.

## Week 9 - Professional Scenarios

Labs:

- `17-import-and-adopt`
- `18-module-versioning-and-promotion`
- `19-multi-team-boundaries`
- `20-policy-hardening`
- `21-incident-recovery`
- `22-capstone`

Outcomes:

- Create local Azure-style resources outside Terraform.
- Import existing resources into Terraform state.
- Converge configuration without replacement.
- Explain the difference between import, drift correction, and recreation.
- Write module release notes and classify module changes.
- Design a dev to stage to prod promotion path.
- Design team ownership boundaries, output contracts, and state separation.
- Harden policy checks and write actionable remediation guidance.
- Practice incident recovery for drift, state inspection, import, and lock scenarios.
- Complete a final capstone package tying architecture, governance, CI, promotion, and recovery together.

Checkpoint:

- Produce a clean post-import plan and write the import commands used.
- Write a promotion packet for a hypothetical `modules/app_stack` release.
- Write an ownership matrix for platform, app, and security teams.
- Run policy pass/fail fixtures and explain the rollout plan.
- Complete an incident report and recovery checklist.
- Submit the capstone checklist, architecture brief, and evaluation artifacts.

## Week 10 - Azure Service Extension

Lab:

- `23-http-api-and-function-app`

Outcomes:

- Explain the difference between a Function App resource and a deployed function.
- Use `azlocal` to create and inspect a local Function App control-plane resource.
- Design a small HTTP-triggered API boundary.
- Identify which Function App dependencies require more validation before becoming Terraform hands-on.

Checkpoint:

- Complete the HTTP API design packet and explain why the local lab is concept/CLI-first rather than Terraform apply-driven.

## Preview Completion Standard

A learner is preview-complete when they can:

- Complete `00` through `04`, `07`, `08`, `09`, `10`, `12`, and `13`.
- Complete concept/local governance Labs `14`, `15`, and `16`.
- Complete professional Labs `17` through `22`.
- Complete service extension Lab `23`.
- Explain the backend limitations documented in `05` and `06`.
- Run `go test -v -timeout 5m` in `11-terratest/test`.
- Read the CI workflow and explain which failures are intentional.
- Describe what would need to change before using real Azure instead of `miniblue`.
