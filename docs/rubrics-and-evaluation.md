# Rubrics And Evaluation

Use these rubrics to decide whether a learner is ready to move from the preview foundation track into team, governance, and professional scenarios.

## Preview-Ready Rubric

Pass means the learner can:

- Start `miniblue` and verify Terraform can reach the local Azure-style endpoints.
- Complete the hands-on labs from `01` through `04`.
- Explain why Labs `05` and `06` are concept-first in this preview.
- Build and consume the module in `07-modules`.
- Use `terraform console` to test expressions.
- Complete the refactor and state exercises in `09` and `13` without treating state commands casually.
- Diagnose the intentional failures in `10-breakfix` and `12-exam-drills`.
- Run the default Terratest suite for Lab `11`.
- Explain what the GitHub Actions workflow validates.

## Associate-Style Readiness

Strong learners can:

- Predict plan output before applying.
- Explain resource addressing and stable identity.
- Use variables, locals, outputs, `for_each`, and dynamic blocks.
- Describe local state, remote state, locking, and migration workflows.
- Refactor configuration without causing avoidable replacement.
- Distinguish syntax errors, provider/version errors, drift, and dependency cycles.

Needs more practice if:

- They run `apply` before reading the plan.
- They change `for_each` keys without considering state impact.
- They solve validation errors by deleting code until it passes.
- They cannot explain why a state command is safe before running it.

## Instructor Or Reviewer Checklist

Ask the learner to demonstrate:

- A clean `terraform fmt` and `terraform validate` run on one lab.
- A plan prediction before applying a small change.
- A safe refactor using `moved` blocks or `terraform state mv`.
- A short explanation of the `azurerm` backend limitation with `miniblue`.
- A read-through of `.github/workflows/ci.yml`, including the intentional failure checks.

## Preview Graduation

The learner is ready for the next track when they can complete the preview labs and explain:

- How Terraform decides what to change.
- How state connects configuration to managed infrastructure.
- How module boundaries help teams reuse infrastructure safely.
- Why local emulation is useful and where it stops being the same as real Azure.

## Capstone Rubric

Pass means the learner can:

- Explain the `modules/app_stack` contract.
- Compare `live/dev`, `live/stage`, and `live/prod`.
- Run or interpret the preview smoke checks.
- Explain policy pass/fail results and remediation.
- Describe a safe module promotion path.
- Describe team ownership boundaries.
- Complete an incident recovery report.
- State what would change before using real Azure.
