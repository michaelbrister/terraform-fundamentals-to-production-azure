# Azure Edition Publication Status

## Current recommendation

This course is ready for a **first public preview** after GitHub Actions passes on the preview branch.

It is not yet at AWS-course parity.

## Preview-ready scope

The preview covers:

- `00-bootstrap`
- `01-local-basics`
- `02-language-basics`
- `03-for-each-patterns`
- `04-dynamic-patterns`
- `05-backend-bootstrap`
- `06-state-migration`
- `07-modules`
- `08-terraform-console`
- `09-refactor-state`
- `10-breakfix`
- `11-terratest`
- `12-exam-drills`
- `13-state-subcommands`
- `live/dev`, `live/stage`, `live/prod`
- `modules/app_stack`

## Hands-on labs

These are intended to be runnable against `miniblue`:

- `00-bootstrap`
- `01-local-basics`
- `02-language-basics`
- `03-for-each-patterns`
- `04-dynamic-patterns`
- `07-modules`
- `08-terraform-console`
- `09-refactor-state`
- `10-breakfix`
- `11-terratest`
- `12-exam-drills`
- `13-state-subcommands`
- `live/*`

Some labs contain intentionally broken Terraform as part of the exercise.

## Concept-first labs

These are intentionally concept-first in the Azure preview:

- `05-backend-bootstrap`
- `06-state-migration`

Reason:

- Terraform's `backend "azurerm"` flow resolves standard Azure Blob hostnames.
- `miniblue` currently exposes local emulator endpoints that are not a drop-in target for that backend path.

## Known limitations

- No fully local `backend "azurerm"` migration lab yet.
- No full end-to-end apply sweep has been run across every lab in this workspace.
- The first-publication apply/destroy smoke sweep has passed for Labs `01`, `02`, `03`, `04`, `07`, and `13` against local `miniblue`.
- Advanced Azure service labs are scaffolded but not implemented.
- Governance and professional scenario tracks are not implemented yet.

## Publication support now in place

- Learner-facing lab status matrix in the top-level `README.md`.
- Self-paced preview syllabus in `docs/syllabus-self-paced.md`.
- Azure-aware Terraform glossary in `docs/glossary.md`.
- Associate-style objective mapping in `docs/associate-objective-mapping.md`.
- Preview readiness rubric in `docs/rubrics-and-evaluation.md`.
- GitHub Actions CI for Terraform formatting, validation, intentional failure checks, and the default Terratest suite.
- Local publication smoke script in `scripts/preview-smoke.sh`.

## First publication checklist

- [x] Run `bash scripts/preview-smoke.sh`.
- [ ] Confirm GitHub Actions CI passes on the preview branch.
- [x] Run `00-bootstrap` on a clean machine.
- [x] Run `bash scripts/preview-smoke.sh --apply-miniblue`.
- [ ] Run `terraform console` examples in Lab `08`.
- [ ] Run selected Lab `09` and Lab `10` scenarios.
- [x] Run default `go test` for Lab `11`.
- [ ] Optionally run `RUN_MINIBLUE_TESTS=1 go test -v -timeout 25m`.
- [x] Apply/destroy Lab `13`.
- [ ] Update the top-level README status to "public preview".

## Full parity requirements

To reach parity with the AWS course, still build:

- `14-tfc-workspaces-and-runs`
- `15-team-rbac-and-variables`
- `16-governance-sentinel-opa-and-approvals`
- `17-import-and-adopt`
- `18-module-versioning-and-promotion`
- `19-multi-team-boundaries`
- `20-policy-hardening`
- `21-incident-recovery`
- `22-capstone`
- `23-http-api-and-function-app`
- `24-entra-auth`
- `25-event-grid-to-function`
