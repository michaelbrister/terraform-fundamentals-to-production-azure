# AWS Course -> Azure Course Mapping

This document maps the existing AWS-oriented course structure to Azure-native equivalents.

## Guiding rule

Do not rewrite the course around Azure services first. Keep the Terraform learning arc intact, then swap cloud examples where the provider matters.

## Directly portable labs

These labs are mostly Terraform concepts and can keep nearly the same learning objectives:

| Existing lab | Azure plan |
| --- | --- |
| `01-local-basics` | Keep; use `azurerm_resource_group`, `random_string`, outputs |
| `02-language-basics` | Keep; teach variables, locals, outputs with Azure naming/location examples |
| `03-for-each-patterns` | Keep; create multiple resource groups, storage accounts, or tags via `for_each` |
| `04-dynamic-patterns` | Keep; use NSG security rules, app settings, or optional subnet/service blocks |
| `07-modules` | Keep; package a reusable Azure stack module |
| `08-terraform-console` | Keep; cloud-agnostic |
| `09-refactor-state` | Keep; use Azure resources in examples |
| `10-breakfix` | Keep; scenarios stay relevant with Azure naming, drift, locks, and imports |
| `11-terratest` | Keep; validate Azure module behavior or outputs |
| `12-exam-drills` | Keep; mostly Terraform-core concepts, with provider-specific flavor where useful |
| `13-state-subcommands` | Keep; cloud-agnostic |
| `14-tfc-workspaces-and-runs` | Keep; provider-agnostic workflow lab |
| `15-team-rbac-and-variables` | Keep; tie examples to Azure environments and secrets |
| `16-governance-sentinel-opa-and-approvals` | Keep; adapt policies to Azure tags, regions, SKUs, and public exposure |
| `17-import-and-adopt` | Keep; import Azure resources and converge safely |
| `18-module-versioning-and-promotion` | Keep; provider-agnostic |
| `19-multi-team-boundaries` | Keep; use subscriptions, resource groups, and ownership boundaries |
| `20-policy-hardening` | Keep; enforce Azure-safe defaults |
| `21-incident-recovery` | Keep; use Azure state/backend/identity recovery scenarios |
| `22-capstone` | Keep; deliver a full Azure stack with environments and governance |

## Labs that need real Azure-specific translation

### `00-bootstrap`

AWS version:

- Docker
- Floci
- fake credentials

Azure version should become:

- Docker or local binary install for `miniblue`
- `miniblue` startup and health checks
- `azlocal` or Azure CLI custom-cloud workflow if needed
- Terraform provider setup for the emulator
- naming conventions for local subscriptions, resource groups, and environments

Notes:

- `miniblue` positions itself as a local Azure emulator with 21 services and Terraform support
- the course should default to local emulation first, then optionally show how labs map to real Azure later

### `05-backend-bootstrap`

AWS version:

- S3 bucket
- DynamoDB lock table

Azure version:

- emulated storage account
- blob container for state
- emulated resource group for backend resources

Notes:

- Azure backend uses blob leases for locking, so there is no DynamoDB-style lock table equivalent
- the lab should explicitly explain that the locking mechanism changed but the collaboration problem is the same
- live validation showed that Terraform's `azurerm` backend currently fails against `miniblue` because backend access resolves standard `blob.core.windows.net` hostnames rather than the emulator's local endpoint shape
- Labs `05` and `06` therefore need a documented fallback or a redesigned teaching approach

### `06-state-migration`

AWS version:

- local to S3 backend

Azure version:

- local to `azurerm` backend in emulated Azure Storage, if supported well enough by `miniblue`

Notes:

- preserve the same mental model: migrate Terraform's memory, not the infrastructure
- this is not currently part of the proven `miniblue` path and should not be written as a normal hands-on lab until the backend story is resolved

## Advanced service lab replacements

### `23-http-api-and-function-app`

Replace:

- API Gateway + Lambda

With:

- Azure Function App or emulator-supported function registration flow
- HTTP trigger
- storage account and hosting plan equivalent where supported
- optional observability notes only if emulator behavior is sufficient

### `24-entra-auth`

Replace:

- Cognito auth

With:

- identity/auth topic adapted to whatever `miniblue` can realistically emulate
- likely managed identity, app registration concepts, or a split between local conceptual lab and real-Azure appendix
- optional app roles or group assignment concepts if they remain mostly documentation-driven

### `25-event-grid-to-function`

Replace:

- DynamoDB streams to Lambda

With:

- Event Grid event subscription
- Storage event or custom event source
- Azure Function consumer

Notes:

- keep this lab only if `miniblue` supports enough end-to-end behavior to make it teachable rather than purely declarative

## Proposed Azure capstone themes

Pick one of these for the final course build:

1. Web/API stack
   Use resource group, storage, Function App, Key Vault, monitoring, and CI policies.
2. Messaging/event stack
   Use Storage Queue or Service Bus plus Function processing and monitoring.
3. Data platform starter
   Use storage account, Key Vault, diagnostic settings, tags, and promotion workflow.

## Shared module suggestion

The Azure `modules/app_stack` module should likely model a few stable building blocks rather than every Azure service:

- resource group
- storage accounts
- log analytics or monitoring hook
- optional Key Vault
- optional Service Bus or queueing component
- optional Function App wiring

That gives enough surface area for variables, dynamic blocks, modules, tests, and policy without forcing the whole course into one service family.
