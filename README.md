# Terraform Fundamentals -> Production (Azure Edition)

> A planned Azure-focused companion course that mirrors the existing AWS-oriented Terraform program.

**Status:** Public preview
**Created:** 2026-04-12

## Goal

Create an Azure-native version of the existing `terraform-fundamentals-to-production` course without losing the original learning progression:

- Foundations first
- State and backend discipline early
- Modules, refactors, and troubleshooting in the middle
- Team workflows, governance, and policy after core skills
- Professional scenarios and capstone at the end

## Proposed audience

- New Terraform users learning against Azure
- Teams standardizing on `azurerm` instead of `aws`
- Engineers who want the same course flow but with Azure services, IAM, and backend patterns

## Default platform choice

This Azure edition now assumes a **local-first workflow using `miniblue`** rather than requiring learners to create Azure accounts at the start.

That makes the course shape much closer to the AWS version:

- `00-bootstrap` should focus on Docker or local `miniblue` install
- foundational labs should target locally emulated Azure services first
- later docs can include a "run this against real Azure" appendix where useful

`miniblue` presents itself as a local Azure emulator with Terraform support and documents a Terraform integration path via `metadata_host = "localhost:4567"` plus local service endpoints. Source: [miniblue docs](https://miniblue.io/). This makes it a reasonable Azure-side counterpart to the AWS course's local emulator approach.

## Proposed course tracks

### Track A - Foundations (01-13)

Keep the same sequence because the Terraform concepts are portable:

1. `01-local-basics`
2. `02-language-basics`
3. `03-for-each-patterns`
4. `04-dynamic-patterns`
5. `05-backend-bootstrap`
6. `06-state-migration`
7. `07-modules`
8. `08-terraform-console`
9. `09-refactor-state`
10. `10-breakfix`
11. `11-terratest`
12. `12-exam-drills`
13. `13-state-subcommands`

### Track B - Team and Governance (14-16)

Keep the same conceptual structure:

14. `14-tfc-workspaces-and-runs`
15. `15-team-rbac-and-variables`
16. `16-governance-sentinel-opa-and-approvals`

### Track C - Professional scenarios (17-22)

Keep the same sequence and adapt examples to Azure resources:

17. `17-import-and-adopt`
18. `18-module-versioning-and-promotion`
19. `19-multi-team-boundaries`
20. `20-policy-hardening`
21. `21-incident-recovery`
22. `22-capstone`

### Track D - Azure service labs (23-25)

Replace the AWS-specific advanced labs with Azure equivalents:

23. `23-http-api-and-function-app`
24. `24-entra-auth`
25. `25-event-grid-to-function`

## Folder scaffold

This scaffold intentionally mirrors the existing repository layout:

- lab folders `00` through `25`
- `docs/` for syllabus, mapping, and rollout notes
- `live/dev`, `live/stage`, `live/prod` for environment examples
- `modules/app_stack` for a reusable Azure stack module
- `policy/` for OPA, Sentinel, and governance examples

## Planning docs

- `docs/associate-objective-mapping.md`
- `docs/aws-to-azure-mapping.md`
- `docs/course-progression-checklist.md`
- `docs/glossary.md`
- `docs/implementation-notes.md`
- `docs/miniblue-validation.md`
- `docs/miniblue-service-validation.md`
- `docs/publication-status.md`
- `docs/rubrics-and-evaluation.md`
- `docs/syllabus-self-paced.md`

## Preview status

The Azure edition now has a complete first Associate-style track from `00-bootstrap` through `13-state-subcommands`, plus preview-ready Team and Governance labs `14` through `16`.

Important caveat:

- Labs `05` and `06` are concept-first because the fully local `backend "azurerm"` path is not currently proven on `miniblue`.
- Professional and Azure service extension tracks remain planned.

## Lab status matrix

| Lab | Status | Mode | Notes |
| --- | --- | --- | --- |
| `00-bootstrap` | Preview-ready | Hands-on | Install/start `miniblue`, trust certs, verify local endpoints |
| `01-local-basics` | Preview-ready | Hands-on | Resource group + local state |
| `02-language-basics` | Preview-ready | Hands-on | Variables, locals, outputs, tags |
| `03-for-each-patterns` | Preview-ready | Hands-on | Stable map identity with RG/VNet/NSG examples |
| `04-dynamic-patterns` | Preview-ready | Hands-on | Dynamic NSG `security_rule` blocks |
| `05-backend-bootstrap` | Preview-ready | Concept-first | Azure Storage backend model; local backend path deferred |
| `06-state-migration` | Preview-ready | Concept-first | `azurerm` backend migration workflow; local backend path deferred |
| `07-modules` | Preview-ready | Hands-on | Shared Azure `app_stack` module |
| `08-terraform-console` | Preview-ready | Hands-on | Console expressions; no apply required |
| `09-refactor-state` | Preview-ready | Hands-on | Multi-step state/refactor/import lab |
| `10-breakfix` | Preview-ready | Mixed | Includes intentional parse error and safe break/fix scenarios |
| `11-terratest` | Preview-ready | Opt-in integration | Default test compiles/skips; `RUN_MINIBLUE_TESTS=1` applies resources |
| `12-exam-drills` | Preview-ready | Mixed | Timed drills, including intentional provider/cycle failures |
| `13-state-subcommands` | Preview-ready | Hands-on | State list/show/mv/rm drills |
| `14-tfc-workspaces-and-runs` | Preview-ready | Concept/local | Terraform Cloud workspace/run concepts mapped to GitHub Actions and folders |
| `15-team-rbac-and-variables` | Preview-ready | Concept/local | Team roles, Azure RBAC concepts, variable ownership, and secrets handling |
| `16-governance-sentinel-opa-and-approvals` | Preview-ready | Concept/local | Sentinel concepts via local OPA policy examples and approval design |
| `17-import-and-adopt` | Preview-ready | Hands-on | Import an existing resource group into Terraform without recreation |
| `18-module-versioning-and-promotion` | Preview-ready | Concept/local | Module release notes, versioning strategy, and dev-stage-prod promotion checklist |
| `19-multi-team-boundaries` | Preview-ready | Concept/local | Ownership matrix, state boundary design, and output contracts |
| `20-policy-hardening` | Preview-ready | Hands-on/local | Harden OPA guardrails, run pass/fail fixtures, and write remediation guidance |
| `21-incident-recovery` | Preview-ready | Concept/local | Drift, lock, state, import, and incident report recovery drills |
| `22-capstone` | Preview-ready | Capstone | Final architecture, governance, CI, promotion, and recovery deliverables |
| `23`-`25` | Planned | Not implemented | Azure service extension labs; Function App, queue, and Event Grid topic probes complete; end-to-end Event Grid delivery still needs validation |

## Recommended next build order

1. Draft Lab `23` as a concept/CLI-first Function App lab using the validated `azlocal functionapp create/list` path
2. Draft Lab `24` as a concept-first Entra/Auth lab because local AD/identity commands are not exposed by `miniblue`
3. Draft Lab `25` around Terraform-validated Event Grid topic creation, then keep event subscription and delivery as a validation checkpoint
4. Add instructor-led materials after the self-paced preview stabilizes
5. Revisit a fully local `backend "azurerm"` path if `miniblue` adds backend-compatible endpoint support

## Preview smoke check

Run the default local/CI-style smoke pass:

```bash
bash scripts/preview-smoke.sh
```

After starting `miniblue`, run the apply/destroy smoke pass for the first-publication hands-on roots:

```bash
bash scripts/preview-smoke.sh --apply-miniblue
```
