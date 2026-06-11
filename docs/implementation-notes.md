# Azure Edition Implementation Notes

## Assumptions used for this first scaffold

1. We are planning a parallel course, not rewriting the existing AWS folder in place.
2. The Azure edition should preserve the learning sequence of the AWS course as closely as possible.
3. The first deliverable is structure and curriculum planning, not complete Terraform lab implementation.
4. The Azure edition should target `miniblue` first so learners do not need Azure accounts unnecessarily.

## Design decisions

### Keep numbering stable

The numbering from `00` to `25` is worth preserving because:

- it keeps the progression easy to compare with the AWS course
- it reduces friction if learners or instructors cross-reference both editions
- it avoids renumbering downstream docs and checklists

### Rename only the provider-dependent advanced labs

Most of the course is about Terraform, not AWS. Only the backend and service-specific labs need strong Azure translation.

### Preserve the governance track

Terraform Cloud, CI, approvals, OPA, and policy-as-code are still relevant in Azure-focused training. Those labs should stay conceptually intact.

## Areas that need a decision before writing labs

### Authentication model

We should choose one primary local auth story for the course:

- direct Terraform configuration against `miniblue`
- `azlocal` or Azure CLI custom-cloud usage where needed
- a later appendix for real Azure auth (`az login`, service principal, or OIDC)

My recommendation:

- teach `miniblue` first for local labs
- introduce real Azure auth later only as an optional extension

### Backend naming and isolation

We should decide whether all learners share one local backend naming pattern or each learner creates an isolated backend stack inside the emulator.

My recommendation:

- each learner gets an isolated backend resource group and storage account naming prefix
- live validation showed that `miniblue` can create storage accounts via ARM, but Terraform backend access still fails when it resolves the standard `blob.core.windows.net` endpoint
- treat Labs `05` and `06` as a separate decision, not part of the proven local-first path

### Emulator support boundary

The main risk now is not Terraform design, but feature support in the emulator.

My recommendation:

- verify `miniblue` coverage for the specific resources we want to teach before writing advanced labs
- keep Labs `23`-`25` flexible until we know which end-to-end flows are solid
- keep early labs focused on resource groups, virtual networks, subnets, and NSGs, which validated successfully
- avoid assuming `azurerm_key_vault` and `backend "azurerm"` are ready for local-first labs

### Capstone service family

The capstone should avoid becoming an Azure product survey. It should use a small, repeatable set of services that exercise real Terraform skills.

My recommendation:

- center the capstone on resource groups, storage, Key Vault, optional Service Bus, and optional Function App

## Suggested next implementation slice

If we continue from this scaffold, the highest-value next step is:

1. write `00-bootstrap/README.md`
2. build `01-local-basics` through `06-state-migration`
3. define `modules/app_stack` for Azure
4. create `live/dev`, `live/stage`, and `live/prod` examples

## Current decision for Labs 05 and 06

We are proceeding with a concept-first implementation for Labs `05` and `06`.

That means:

- the labs still teach backend bootstrap and state migration directly
- the labs stay aligned with the AWS course's mental model
- the labs do not pretend the fully local `backend "azurerm"` path is already solved on `miniblue`
