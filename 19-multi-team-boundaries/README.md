# Lab 19 - Multi-Team Boundaries

## What this lab teaches you

This lab teaches how to split Terraform ownership across teams without creating circular dependencies or shared-state chaos.

You will learn:

- how to choose state boundaries
- how to define platform, application, and security responsibilities
- how outputs become team contracts
- why teams should not reach into each other's state casually
- how to coordinate changes that cross ownership boundaries

## Scenario

Your organization has three teams:

- a platform team that owns shared network foundations
- an application team that owns app-specific infrastructure
- a security team that owns guardrails and review requirements

The teams all use Terraform, but they should not all edit the same root module or share one state file.

Your job is to design clear boundaries before the repo grows.

## Why this matters

One giant Terraform state is simple at first and painful later.

It can cause:

- slow plans
- broad blast radius
- unclear ownership
- accidental resource replacement
- teams blocking each other
- circular dependencies between stacks

Good boundaries make infrastructure easier to review, safer to promote, and less dramatic to recover.

## Boundary model

Use this model for the Azure edition:

| Boundary | Owner | Examples | State ownership |
| --- | --- | --- | --- |
| Platform foundation | Platform team | shared VNets, shared subnets, naming baseline | separate platform state |
| Application stack | App team | app RGs, app NSGs, app subnets, app settings | separate app state |
| Governance | Security/platform team | OPA/Sentinel policy, approvals, required tags | policy repo or shared governance folder |
| Environment roots | Platform + app reviewers | `live/dev`, `live/stage`, `live/prod` | one state per environment/root |

This tutorial currently keeps `live/dev`, `live/stage`, and `live/prod` as separate roots using local state. In real Azure, each root would use a distinct backend key.

## State boundary rule

Use this rule:

> If two teams need different approval paths, credentials, or lifecycles, they probably need different state.

Examples:

- Dev and prod should not share state.
- Platform shared networking should not be owned by an app team's state.
- Policy checks should not depend on mutating application state.
- Outputs are safer contracts than direct state edits.

## Exercise 1 - Identify Current Boundaries

Open:

```bash
live/dev/main.tf
live/stage/main.tf
live/prod/main.tf
modules/app_stack/main.tf
modules/app_stack/outputs.tf
policy/terraform.rego
```

Answer:

- Which files define reusable implementation?
- Which files define environment-specific intent?
- Which files define governance rules?
- Which team should approve each kind of change?

## Exercise 2 - Design Ownership

Use `OWNERSHIP_MATRIX.md` to assign owners.

At minimum, assign ownership for:

- module interface changes
- live environment changes
- production applies
- policy changes
- backend configuration
- provider version upgrades

## Exercise 3 - Define Output Contracts

Outputs are how one stack exposes safe information to another.

Open:

```bash
modules/app_stack/outputs.tf
```

Answer:

- Which outputs are safe for another team to consume?
- Which details should remain internal implementation details?
- What could break if an output name changes?
- How should a team announce output contract changes?

## Exercise 4 - Avoid Circular Dependencies

Read `BOUNDARY_DESIGN.example.md`.

Then sketch two stacks:

- `platform-network`
- `app-workload`

Define:

- what each stack owns
- what each stack outputs
- what each stack consumes
- which team approves changes

The design fails if:

- platform needs outputs from app while app needs outputs from platform
- app modifies resources owned by platform
- security policy requires editing app state directly

## Exercise 5 - Map To Real Azure

In real Azure, the platform team may own:

- hub or shared virtual networks
- shared private DNS zones
- shared route tables
- shared firewall or security inspection

Application teams may own:

- app-specific resource groups
- workload subnets delegated by platform
- app-specific NSGs within approved guardrails

Security teams may own:

- Azure RBAC review
- policy-as-code checks
- allowed regions
- required tags
- production approval rules

Write which of those are represented in this local tutorial and which would require real Azure.

## Deliverable

Create a boundary design note with:

- ownership matrix
- proposed state boundaries
- output contracts
- approval flow
- one example of a bad circular dependency and the corrected design

## Success criteria

You are done when you can explain:

- why state boundaries should follow ownership and lifecycle
- why outputs are contracts
- why direct cross-state edits are dangerous
- how platform, app, and security teams coordinate without sharing one giant root module
- how this local-first repo could evolve into separate production stacks

