# Learner Walkthrough Checklist

Use this checklist for first-publication manual QA.

The automated smoke script proves Terraform formatting, validation, intentional failures, policy fixtures, and the default test suite. This walkthrough proves the course feels coherent to a learner moving through the material.

Record findings in `docs/pilot-feedback.template.md`.

## Recommended Pass Order

Run these after a clean clone or fresh checkout:

1. `00-bootstrap`
2. `01-local-basics`
3. `02-language-basics`
4. `03-for-each-patterns`
5. `04-dynamic-patterns`
6. `08-terraform-console`
7. selected `09-refactor-state` steps
8. selected `10-breakfix` scenarios
9. `13-state-subcommands`
10. one service-extension packet from Labs `23` through `25`

## Environment Setup

Record:

- date
- operating system
- Terraform version
- miniblue version
- Go version, if running Lab `11`
- whether Conftest is installed

Start `miniblue`:

```bash
miniblue
```

Verify health:

```bash
curl -s http://localhost:4566/health
```

## Baseline Automation

Run:

```bash
bash scripts/preview-smoke.sh
```

If Terraform is managed by `mise`:

```bash
mise exec -- bash scripts/preview-smoke.sh
```

Record:

- pass or fail
- Terraform version
- whether policy examples ran or were skipped
- whether Terratest passed

## Apply/Destroy Spot Check

With `miniblue` running, run:

```bash
bash scripts/preview-smoke.sh --apply-miniblue --skip-go
```

Record:

- Labs applied and destroyed
- any cleanup warnings
- whether final destroy completed

## Lab 08 Console Walkthrough

Open:

```bash
08-terraform-console
```

Run the console examples from the lab.

Confirm the learner can explain:

- the difference between values, expressions, and resources
- why console testing is useful before writing configuration
- how collection expressions relate to later `for_each` labs

## Lab 09 Refactor Walkthrough

Run at least two steps from:

```bash
09-refactor-state
```

Recommended:

- `step1`
- `step2`
- `step5`

Confirm the learner can explain:

- what changed in configuration
- whether Terraform planned a replacement
- when a `moved` block is safer than recreating a resource

## Lab 10 Break/Fix Walkthrough

Run or inspect at least three scenarios:

- `scenario-01-parse-error`
- `scenario-03-drift`
- `scenario-05-import-vs-recreate`

Confirm the learner can explain:

- why the intentional parse error fails
- how drift differs from a configuration change
- why import can be safer than recreate

## Lab 13 State Subcommands Walkthrough

Run:

```bash
terraform init -backend=false
terraform apply -auto-approve
terraform state list
terraform state show <address>
terraform destroy -auto-approve
```

Confirm the learner can explain:

- which state commands are read-only
- which commands mutate state
- why state should not be edited casually

## Service Extension Walkthrough

Pick one:

- Lab `23`: complete the HTTP API design packet.
- Lab `24`: complete the identity inventory and auth-flow design.
- Lab `25`: apply/destroy the Event Grid topic validation root and complete the event contract.

Confirm the learner can explain:

- which parts are locally validated
- which parts require real Azure or future emulator support
- why the lab mode is concept-first, CLI-first, or mixed

## Acceptance Criteria

The walkthrough passes when:

- automated smoke checks pass
- selected apply/destroy checks clean up after themselves
- selected learner exercises have clear instructions and expected interpretation
- concept-first labs clearly explain why they are not fully hands-on
- no lab requires an Azure account for the default preview path
- backend, auth, storage, and Event Grid delivery limitations are easy to find

## Notes

Use this section for quick notes, then copy durable findings into `docs/pilot-feedback.template.md`:

-
