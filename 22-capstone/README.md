# Lab 22 - Capstone

## What this lab teaches you

This capstone asks you to demonstrate the full Azure edition learning path.

You will combine:

- local-first Terraform with `miniblue`
- reusable modules
- dev, stage, and prod environment structure
- policy-as-code
- CI validation
- import/adoption thinking
- team boundaries
- incident recovery documentation

## Scenario

Your team is preparing a small Azure platform foundation for an application group.

The platform must be reproducible, reviewable, and governed. It does not need to use real Azure for this capstone. The goal is to prove that your Terraform workflow is safe enough to evolve toward real Azure later.

## Capstone constraints

You must use:

- `modules/app_stack`
- `live/dev`
- `live/stage`
- `live/prod`
- `policy/`
- `.github/workflows/ci.yml`
- at least one professional scenario artifact from Labs `17`-`21`

You must not:

- copy and paste separate infrastructure implementations for each environment
- bypass policy instead of fixing or documenting it
- apply an unexpected destroy or replacement
- delete state as a recovery strategy
- require learners to create a real Azure account

## Required deliverables

Use `SUBMISSION_CHECKLIST.md`.

Your final submission should include:

- architecture brief
- module contract summary
- environment comparison
- policy results
- CI evidence
- promotion notes
- recovery runbook
- final reflection

## Step 1 - Architecture Brief

Start from `ARCHITECTURE_BRIEF.example.md`.

Write:

- what the stack creates
- which resources are shared
- which resources are environment-specific
- what the module owns
- what each environment root owns
- what policy enforces

## Step 2 - Module Contract

Document the contract for:

```bash
modules/app_stack
```

Include:

- required inputs
- optional inputs
- outputs
- ownership
- versioning strategy
- expected safe change types
- risky change types

## Step 3 - Environment Comparison

Compare:

```bash
live/dev
live/stage
live/prod
```

Explain:

- why address ranges differ
- why stage has extra health ingress
- why prod has an additional shared stack
- which changes should promote dev to stage to prod

## Step 4 - Policy Evidence

Run or inspect:

```bash
conftest test policy/examples/azure-plan-pass.json -p policy
conftest test policy/examples/azure-plan-fail.json -p policy
conftest test policy/examples/azure-plan-hardening-fail.json -p policy
```

Record:

- which fixture passes
- which fixtures fail
- what remediation is required
- which failures should be deny vs warn-only during rollout

## Step 5 - CI Evidence

Run:

```bash
bash scripts/preview-smoke.sh
```

If Terraform is managed by `mise` on your machine:

```bash
mise exec -- bash scripts/preview-smoke.sh
```

Record:

- Terraform checks
- intentional failure checks
- policy checks
- Terratest result

## Step 6 - Professional Scenario Evidence

Choose at least two:

- Lab `17`: import and adopt an existing resource group
- Lab `18`: write module release notes and promotion checklist
- Lab `19`: write an ownership matrix and boundary design
- Lab `20`: write policy remediation guidance
- Lab `21`: complete an incident report

## Step 7 - Final Review

Before marking complete, answer:

- Can another learner reproduce your steps?
- Did every plan match your prediction?
- Did policy failures have clear remediation?
- Did you separate plan, review, and apply?
- Did you document what would change for real Azure?

## Success criteria

You are done when you can defend the design, not just run the commands.

A successful capstone shows:

- clean Terraform validation
- clear module boundaries
- clear environment promotion story
- policy checks with remediation
- incident recovery notes
- no hidden dependency on a real Azure subscription

