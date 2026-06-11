# Lab 16 - Governance With Sentinel Concepts, OPA, And Approvals

## What this lab teaches you

This lab teaches policy-as-code and approval gates.

You will learn:

- what policy-as-code is
- what Sentinel policy sets do in Terraform Cloud
- how OPA/Conftest can model similar checks locally
- how policy failures should guide learners instead of surprising them
- why policy checks and human approvals solve different problems

## Why this matters

Reviewers are good at intent and context. Policy is good at repeatable guardrails.

Good Terraform governance uses both:

- policy blocks known-bad patterns
- reviewers evaluate whether the change should happen
- approvals create an audit trail
- CI makes the rules visible before apply

## Concept mapping

| Governance need | Terraform Cloud option | Local-first option in this repo |
| --- | --- | --- |
| Required tags | Sentinel policy set | OPA policy in `policy/terraform.rego` |
| Plan-time enforcement | Run policy checks | `conftest test` against plan JSON |
| Human approval | Apply approval | GitHub environment reviewer |
| Audit trail | Run history | Pull request and Actions history |
| Exception handling | Policy override | Documented reviewer exception process |

## Install optional tooling

This lab uses Conftest if you want to run the policy examples locally.

macOS:

```bash
brew install conftest
```

If you do not install Conftest, you can still read the sample inputs and policy logic.

## Exercise 1 - Read A Passing Plan

Open:

```bash
policy/examples/azure-plan-pass.json
policy/terraform.rego
```

Look for:

- resource group tags
- virtual network tags
- required tag names

If Conftest is installed, run:

```bash
conftest test policy/examples/azure-plan-pass.json -p policy
```

Expected result:

- no policy failures

## Exercise 2 - Read A Failing Plan

Open:

```bash
policy/examples/azure-plan-fail.json
```

Find the missing or invalid tags.

If Conftest is installed, run:

```bash
conftest test policy/examples/azure-plan-fail.json -p policy
```

Expected result:

- policy failures explaining which resource violates the guardrail

## Exercise 3 - Fix The Failing Plan

Copy the failing example to a scratch file and add the missing tags.

Run Conftest again if available.

Answer:

- Which policy failed?
- What was the smallest fix?
- Would disabling the policy be acceptable?

## Exercise 4 - Add An Approval Story

Policy checks do not replace approvals.

Write an approval rule for production:

- CI must pass.
- Policy checks must pass.
- A maintainer must review the plan.
- A different maintainer should approve production apply when possible.
- Emergency exceptions must be documented after the incident.

## Deliverable

Write a short governance note with:

- one policy failure and the fix
- one approval rule for `live/prod`
- one paragraph mapping OPA checks to Sentinel policy sets
- one paragraph explaining when a human can approve something policy cannot evaluate

## Success criteria

You are done when you can explain:

- why policy belongs before apply
- why approvals still matter after policy passes
- how to interpret an OPA policy failure
- how this local-first workflow can later become a Terraform Cloud Sentinel workflow

