# Policy Checks

This folder contains local policy-as-code examples for the Azure edition.

The goal is to teach Terraform Cloud Sentinel concepts with a tool learners can run locally. The examples use OPA/Rego through Conftest.

## Optional install

macOS:

```bash
brew install conftest
```

## Run sample checks

Passing example:

```bash
conftest test policy/examples/azure-plan-pass.json -p policy
```

Failing example:

```bash
conftest test policy/examples/azure-plan-fail.json -p policy
```

## What the policy enforces

For Azure resources that support tags, the policy requires:

- `Environment`
- `ManagedBy`
- `Stack`

For network security group rules, the policy blocks inbound `Allow` rules where both of these are true:

- source is `*`
- destination port is `*`

## Why this is not Sentinel

Sentinel is the Terraform Cloud policy engine. OPA is used here because it works locally and lets learners practice the same workflow:

1. produce or inspect plan JSON
2. run policy checks
3. read failures
4. fix configuration instead of bypassing guardrails

