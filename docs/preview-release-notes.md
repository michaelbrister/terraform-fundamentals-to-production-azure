# Azure Edition Preview Release Notes

## Release Summary

The Azure edition is ready for first public preview.

This preview provides a local-first Terraform learning path from `00-bootstrap` through `25-event-grid-to-function` using `miniblue` as the default Azure-style emulator.

The default path does not require learners to create Azure accounts.

## Included Scope

Preview-ready learning path:

- `00-bootstrap`
- Labs `01` through `13`: Terraform foundations and Associate-style practice
- Labs `14` through `16`: team workflow, RBAC, variables, policy, and approvals
- Labs `17` through `22`: professional scenarios and capstone
- Labs `23` through `25`: Azure service-extension labs
- `live/dev`, `live/stage`, and `live/prod`
- `modules/app_stack`
- local OPA policy examples
- GitHub Actions CI
- local preview smoke script
- learner walkthrough, instructor guide, pilot feedback, and real-Azure appendix docs

## What Runs Locally

The preview includes hands-on local labs for:

- resource groups
- virtual networks
- subnets
- network security groups
- modules
- expression debugging with `terraform console`
- refactor and state workflows
- selected break/fix scenarios
- import/adoption practice
- policy hardening with local fixtures
- Event Grid topic creation through a focused validation root

The first-publication apply/destroy sweep has passed for Labs `01`, `02`, `03`, `04`, `07`, and `13` against `miniblue`.

## Concept-First Or Mixed Labs

Some labs intentionally teach the real Azure mental model without pretending every service is fully emulated locally.

Concept-first labs:

- `05-backend-bootstrap`
- `06-state-migration`
- `14-tfc-workspaces-and-runs`
- `15-team-rbac-and-variables`
- `16-governance-sentinel-opa-and-approvals`
- `18-module-versioning-and-promotion`
- `19-multi-team-boundaries`
- `24-entra-auth`

Mixed or CLI-first service labs:

- `23-http-api-and-function-app`: Function App control-plane validation through `azlocal`; runtime deployment remains real-Azure or future-emulator work.
- `25-event-grid-to-function`: Event Grid topic creation is Terraform-validated; event subscription and Function delivery remain validation checkpoints.

## Known Limitations

The preview does not yet include:

- a fully local `backend "azurerm"` migration path
- end-to-end Event Grid subscription and Function delivery
- fully local Entra app registration, service principal, managed identity, or RBAC flows
- fully local Azure Functions runtime deployment and invocation through Terraform
- a full end-to-end apply sweep across every lab

These are documented boundaries, not hidden failures.

## Validation Evidence

Current validation support:

- `scripts/preview-smoke.sh`
- GitHub Actions CI
- `docs/miniblue-validation.md`
- `docs/miniblue-service-validation.md`
- `validation/miniblue/services/eventgrid-topic`
- `docs/pilot-feedback.dry-run-2026-06-13.md`

Maintainer dry run completed:

- Lab `08` representative console expressions
- Lab `09` selected validation
- Lab `10` intentional parse failure and selected validation
- Lab `13` apply, state list, state show, and destroy

## Recommended First Announcement Copy

Terraform Fundamentals to Production now has an Azure public-preview track.

The Azure edition mirrors the AWS course structure while using `azurerm`, local `miniblue` emulation, Azure-style resources, Azure governance concepts, and service-extension labs for Function App, Entra auth, and Event Grid.

The preview is intentionally local-first: learners can begin without an Azure account, and the course clearly marks where real Azure is still required for production-grade backend, identity, Functions runtime, and Event Grid delivery behavior.

## Next Hardening Work

Recommended next steps:

1. Run the learner walkthrough with someone who did not author the material.
2. Pilot the instructor guide with a small cohort.
3. Validate Event Grid subscription to Function delivery when emulator or real-Azure testing is available.
4. Revisit the fully local `backend "azurerm"` path if `miniblue` adds backend-compatible endpoint behavior.
