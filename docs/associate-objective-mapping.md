# Terraform Associate Objective Mapping

This mapping shows how the Azure preview labs support Terraform Associate-style skills. It is not a replacement for the official exam guide; use it as a course navigation aid.

## Infrastructure As Code Concepts

Covered by:

- `00-bootstrap`
- `01-local-basics`
- `docs/glossary.md`

Learner should be able to:

- Explain why Terraform uses declarative configuration.
- Describe the difference between desired state, actual infrastructure, and Terraform state.
- Explain the tradeoff of using a local emulator for early learning.

## Terraform Workflow

Covered by:

- `01-local-basics`
- `02-language-basics`
- `10-breakfix`
- `.github/workflows/ci.yml`

Learner should be able to:

- Run `init`, `fmt`, `validate`, `plan`, `apply`, and `destroy`.
- Interpret plan output before approving changes.
- Understand why CI runs formatting and validation gates.

## Terraform Configuration Language

Covered by:

- `02-language-basics`
- `03-for-each-patterns`
- `04-dynamic-patterns`
- `08-terraform-console`

Learner should be able to:

- Use variables, locals, outputs, expressions, and collection transforms.
- Choose stable `for_each` keys.
- Use dynamic blocks for optional nested resource settings.
- Test expressions in `terraform console`.

## State Management

Covered by:

- `05-backend-bootstrap`
- `06-state-migration`
- `09-refactor-state`
- `13-state-subcommands`

Learner should be able to:

- Explain why state exists and why teams usually need a remote backend.
- Describe Azure Storage backend components at a conceptual level.
- Use `state list`, `state show`, `state mv`, and `state rm` carefully.
- Refactor resource addresses without unnecessary replacement.

## Modules

Covered by:

- `07-modules`
- `modules/app_stack`
- `live/dev`
- `live/stage`
- `live/prod`

Learner should be able to:

- Consume a local module.
- Explain module inputs, outputs, and provider inheritance.
- Compare environment-specific root modules that share a common module.

## Troubleshooting

Covered by:

- `10-breakfix`
- `11-terratest`
- `12-exam-drills`
- `17-import-and-adopt`

Learner should be able to:

- Diagnose syntax errors and validation failures.
- Recognize identity instability from unsafe keys.
- Explain drift and import-vs-recreate choices.
- Read a test failure without panic spiraling into random edits.
- Import existing infrastructure and converge configuration without recreation.

## Team Workflow And Governance Concepts

Covered by:

- CI introduces automated validation gates.
- Labs `05` and `06` introduce backend and locking concepts.
- `14-tfc-workspaces-and-runs`
- `15-team-rbac-and-variables`
- `16-governance-sentinel-opa-and-approvals`
- `policy/`

Learner should be able to:

- Explain workspaces, runs, speculative plans, and approval gates.
- Describe team RBAC and variable governance.
- Explain why secrets should be stored outside Git.
- Map local OPA checks to Terraform Cloud Sentinel policy concepts.
