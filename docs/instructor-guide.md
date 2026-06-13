# Instructor Guide

This guide helps instructors run the Azure edition as a workshop or cohort without requiring learners to create Azure accounts.

The course is designed for local-first delivery with `miniblue`. Real Azure appendices are optional and should be treated as advanced extensions, not prerequisites.

## Delivery Formats

### Two-Day Intensive

Use this when learners already know basic CLI workflows.

Day 1:

- `00-bootstrap`
- `01-local-basics`
- `02-language-basics`
- `03-for-each-patterns`
- `04-dynamic-patterns`
- `08-terraform-console`
- selected `10-breakfix` scenario

Day 2:

- `07-modules`
- selected `09-refactor-state` steps
- `13-state-subcommands`
- one governance discussion from Labs `14` through `16`
- one service-extension design packet from Labs `23` through `25`

### Five-Session Cohort

Use this when learners are newer to Terraform.

1. Foundations: `00`, `01`, `02`
2. Collections and dynamic config: `03`, `04`, `08`
3. State, modules, and refactors: `05`, `06`, `07`, `09`, `13`
4. Troubleshooting and governance: `10`, `11`, `12`, `14`, `15`, `16`
5. Professional and service design: `17` through `25`

### Self-Paced With Office Hours

Use `docs/syllabus-self-paced.md` as the main path.

Office hours should focus on:

- plan prediction
- state and backend mental models
- `for_each` identity
- refactor safety
- emulator boundaries
- service-extension design decisions

## Instructor Setup

Before teaching, run:

```bash
bash scripts/preview-smoke.sh
```

If Terraform is managed by `mise`:

```bash
mise exec -- bash scripts/preview-smoke.sh
```

For hands-on demos with local applies:

```bash
miniblue
bash scripts/preview-smoke.sh --apply-miniblue --skip-go
```

Have these docs open:

- `README.md`
- `docs/publication-status.md`
- `docs/learner-walkthrough-checklist.md`
- `docs/miniblue-validation.md`
- `docs/miniblue-service-validation.md`
- `docs/real-azure-appendices.md`

## Teaching Emphasis

Keep returning to these habits:

- predict before plan
- read the plan before apply
- prefer stable map keys over list indexes for long-lived resources
- treat state as Terraform's record of ownership, not as a mystery file
- refactor with explicit state-aware moves
- separate local emulator proof from real Azure proof
- document concept-first boundaries instead of hand-waving them away

## Demo Recommendations

High-confidence live demos:

- `01-local-basics`
- `02-language-basics`
- `03-for-each-patterns`
- `04-dynamic-patterns`
- `07-modules`
- `08-terraform-console`
- selected `09-refactor-state` steps
- `13-state-subcommands`
- `20-policy-hardening`
- Event Grid topic validation root used by Lab `25`

Discussion-first demos:

- `05-backend-bootstrap`
- `06-state-migration`
- Labs `14` through `16`
- Labs `18` and `19`
- Lab `24`

Use care:

- Do not present `backend "azurerm"` as locally solved.
- Do not present Function App creation as proof of deployed function runtime behavior.
- Do not present local token endpoints as Entra ID.
- Do not present Event Grid topic creation as proof of Function delivery.

## Facilitation Prompts

Ask these questions repeatedly:

- What do you expect Terraform to create, update, or destroy?
- Which resource address owns this object?
- What would happen if this `for_each` key changed?
- Is this a configuration change, state change, or reality drift?
- Which part of this lab is proven locally?
- Which part would require real Azure?
- Who owns this variable, secret, or approval?

## Common Learner Stumbles

| Symptom | Instructor response |
| --- | --- |
| Learner wants to run apply immediately | Ask for a plan prediction first |
| Learner changes list order or map keys casually | Revisit stable identity and resource addresses |
| Learner treats state as disposable | Reframe state as ownership evidence |
| Learner expects Labs `05` and `06` to apply locally | Point to the backend limitation and concept-first purpose |
| Learner assumes `azlocal` service creation proves runtime behavior | Separate control-plane validation from data-plane/runtime validation |
| Learner wants real Azure too early | Use `docs/real-azure-appendices.md` as the readiness gate |

## Assessment

Use `docs/rubrics-and-evaluation.md`.

For a workshop completion check, ask each learner to submit:

- one plan prediction
- one successful apply/destroy transcript or summary
- one state inspection explanation
- one refactor or import explanation
- one service-extension boundary explanation

The goal is not memorizing commands. The goal is safe Terraform judgment.

After the session, complete `docs/pilot-feedback.template.md` and convert follow-up actions into issues or small documentation patches.
