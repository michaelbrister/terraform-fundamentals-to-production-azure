# Pilot Feedback - Dry Run 2026-06-13

Use this as the first internal pilot record for the Azure preview path.

## Pilot Metadata

- Date: 2026-06-13
- Facilitator: local dry run
- Format: maintainer walkthrough
- Number of learners: 0
- Learner background: not applicable
- Repo commit: working tree clean before run
- Terraform version: 1.15.6 via `mise`
- miniblue version: 0.7.0
- Operating systems: macOS

## Overall Result

- [x] Completed without blockers
- [ ] Completed with minor issues
- [ ] Completed with major issues
- [ ] Did not complete

Summary:

- Selected learner walkthrough checks completed successfully.
- No documentation blockers were found during this dry run.
- Terraform apply/destroy for Lab `13` cleaned up without leaving tracked changes.

## Setup Feedback

What worked:

- `miniblue` started and reported healthy on `http://localhost:4566/health`.
- Terraform provider initialization reused local provider cache successfully.
- Lab `13` resource groups applied and destroyed cleanly.

What blocked or slowed learners:

- No blocker found in this dry run.

Follow-up actions:

- Run the same walkthrough with at least one real learner or instructor who did not author the material.

## Lab Feedback

| Lab or doc | What happened | Severity | Owner | Follow-up |
| --- | --- | --- | --- | --- |
| `08-terraform-console` | Representative expressions returned expected values and types. | `P3` | n/a | No action. |
| `10-breakfix/scenario-01-parse-error` | `terraform validate` failed with the expected missing attribute separator error. | `P3` | n/a | No action. |
| `10-breakfix/scenario-05-import-vs-recreate` | `terraform init` and `terraform validate` passed. | `P3` | n/a | No action. |
| `09-refactor-state/step1` | `terraform init` and `terraform validate` passed. | `P3` | n/a | No action. |
| `13-state-subcommands` | `apply`, `state list`, `state show`, and `destroy` all worked. | `P3` | n/a | No action. |

## Emulator Boundary Feedback

Did learners understand:

- [x] why Labs `05` and `06` are concept-first
- [x] why Lab `23` is Function App control-plane only
- [x] why Lab `24` is Entra design-only
- [x] why Lab `25` is Event Grid topic hands-on but delivery design-first

Notes:

- This was a maintainer dry run, so understanding was checked against the docs rather than learner questions.

## Timing

| Segment | Planned time | Actual time | Notes |
| --- | --- | --- | --- |
| Setup | 10m | 5m | `miniblue` started cleanly. |
| Foundations | n/a | n/a | Not rerun in this focused pass. |
| Collections/dynamic config | 10m | 5m | Console expressions behaved as expected. |
| State/refactor | 20m | 10m | Lab `13` apply/state/destroy and Lab `09` validation passed. |
| Break/fix | 10m | 5m | Expected parse failure confirmed. |
| Governance | n/a | n/a | Not rerun in this focused pass. |
| Service extension | n/a | n/a | Not rerun in this focused pass. |

## Assessment Evidence

Learners could explain:

- [x] plan prediction
- [x] state ownership
- [x] stable `for_each` keys
- [x] refactor safety
- [x] drift/import/recreate tradeoffs
- [x] local emulator boundaries
- [x] real Azure readiness requirements

Notes:

- Evidence is based on documentation coverage plus successful command output, not a live learner interview.

## Decisions

Changes to make before next pilot:

- No immediate edits required from this dry run.

Changes to defer:

- End-to-end Event Grid subscription and Function delivery validation.
- Fully local `backend "azurerm"` support.

Open questions:

- Which real learner profile should be used for the first external pilot: Terraform beginner, Azure engineer, or platform engineer?
