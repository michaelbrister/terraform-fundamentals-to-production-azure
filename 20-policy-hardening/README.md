# Lab 20 - Policy Hardening

## What this lab teaches you

This lab teaches how to make policy stricter without surprising every team at once.

You will learn:

- how to add policy rules safely
- how to write remediation guidance
- how to distinguish warn-only rollout from deny enforcement
- how to avoid policies that are technically correct but operationally painful
- how Azure networking guardrails fit into Terraform review

## Scenario

Your organization already checks basic Terraform plans with OPA.

Security now asks for stronger Azure guardrails:

- every taggable resource must include `Name`
- every environment tag must be one of the approved values
- inbound NSG rules must not allow wildcard sources
- inbound NSG rules must not allow all ports

You need to harden the policy while keeping the developer experience clear and fixable.

## Why this matters

Policy is not just about blocking bad changes.

Good policy should:

- fail early
- explain the problem clearly
- tell teams how to fix it
- avoid blocking unrelated work
- have a rollout plan

Bad policy creates panic and bypass culture. Good policy creates trust.

## Policy files

Open:

```bash
policy/terraform.rego
policy/examples/azure-plan-pass.json
policy/examples/azure-plan-fail.json
policy/examples/azure-plan-hardening-fail.json
```

The policy currently checks Azure-style Terraform plan JSON.

## Exercise 1 - Run The Baseline Examples

Passing example:

```bash
conftest test policy/examples/azure-plan-pass.json -p policy
```

Failing example:

```bash
conftest test policy/examples/azure-plan-fail.json -p policy
```

Hardening failure example:

```bash
conftest test policy/examples/azure-plan-hardening-fail.json -p policy
```

If Conftest is not installed, read the JSON files and policy messages instead.

## Exercise 2 - Explain Each Failure

For each failure, write:

- the resource address
- the policy rule that failed
- the smallest safe fix
- whether the fix changes infrastructure or only metadata
- whether this should be warn-only or deny on day one

## Exercise 3 - Write Remediation Guidance

Use `REMEDIATION_GUIDE.md`.

Add one example for:

- missing required tag
- invalid environment tag
- wildcard inbound source
- wildcard inbound destination port

## Exercise 4 - Design A Phased Rollout

Use this rollout model:

1. **Observe**: run policy locally and collect failures.
2. **Warn**: show failures in CI but do not block merges.
3. **Deny new violations**: block new or changed resources that violate policy.
4. **Deny all violations**: block all violating plans after teams have remediated legacy resources.

Answer:

- Which rules can be deny immediately?
- Which rules should start warn-only?
- Who can approve exceptions?
- Where should exceptions be documented?

## Exercise 5 - Avoid Bad Policy

Review the rules and answer:

- Does the policy have clear messages?
- Could a team fix failures without asking the policy author?
- Does the policy block deletes?
- Does it block untouched legacy resources?
- Does it distinguish metadata fixes from risky network changes?

## Deliverable

Write a policy hardening packet with:

- policy failures and fixes
- phased rollout plan
- exception process
- reviewer checklist
- one example of a policy that would be too broad

## Success criteria

You are done when you can explain:

- how to add policy without causing chaos
- why warning phases can be useful
- why policy failures need actionable remediation
- how Azure NSG guardrails reduce blast radius
- how this local OPA workflow maps to Sentinel policy sets in Terraform Cloud

