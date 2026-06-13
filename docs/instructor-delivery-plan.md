# Instructor Delivery Plan

Use this as a lightweight agenda template for instructor-led delivery.

## Workshop Metadata

- Date:
- Instructor:
- Audience:
- Format:
- Terraform version:
- miniblue version:
- Repo commit:

## Preflight

- [ ] Instructor ran `bash scripts/preview-smoke.sh`.
- [ ] Instructor ran `bash scripts/preview-smoke.sh --apply-miniblue --skip-go`.
- [ ] Learners have Terraform installed.
- [ ] Learners have `miniblue` installed.
- [ ] Learners can run `curl -s http://localhost:4566/health`.
- [ ] Learners know the default path does not require an Azure account.

## Agenda

| Segment | Time | Labs | Outcome |
| --- | --- | --- | --- |
| Orientation | 30m | `00-bootstrap` | Learners can start and verify `miniblue` |
| Core workflow | 60m | `01`, `02` | Learners can init, plan, apply, destroy, and explain state |
| Collections | 60m | `03`, `08` | Learners can reason about stable keys and expressions |
| Dynamic config | 45m | `04` | Learners can model optional nested config |
| State and refactor | 75m | `09`, `13` | Learners can inspect state and refactor safely |
| Break/fix | 60m | `10`, `12` | Learners can diagnose common failures |
| Governance | 45m | `14`-`16` | Learners can explain approvals, variables, and policy |
| Professional scenarios | 60m | `17`-`22` | Learners can connect import, promotion, boundaries, policy, recovery, and capstone |
| Service extension | 60m | `23`-`25` | Learners can separate local proof from real Azure proof |

## Required Demos

- [ ] `01-local-basics` apply/destroy
- [ ] `03-for-each-patterns` key stability discussion
- [ ] `08-terraform-console` expression check
- [ ] one `09-refactor-state` step
- [ ] one intentional failure from `10-breakfix` or `12-exam-drills`
- [ ] policy pass/fail fixture from `20-policy-hardening`
- [ ] service-extension boundary explanation from Lab `23`, `24`, or `25`

## Discussion Prompts

- What does Terraform know from configuration?
- What does Terraform know from state?
- What does the provider discover from the remote API?
- Why is a local emulator useful?
- Where does a local emulator stop matching real Azure?
- What evidence would make this safe for production?

## Completion Evidence

Each learner should leave with:

- one successful local apply/destroy
- one console or expression explanation
- one state inspection explanation
- one troubleshooting explanation
- one service-extension design note

## Follow-Up

- [ ] Record confusing lab wording.
- [ ] Record setup issues.
- [ ] Record miniblue behavior differences.
- [ ] Record labs that need more examples.
- [ ] Record whether real-Azure appendices should be used in a future cohort.
