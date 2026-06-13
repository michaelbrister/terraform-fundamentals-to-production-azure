# Azure Edition Implementation Notes

## Current course assumptions

1. We are building a parallel course, not rewriting the existing AWS folder in place.
2. The Azure edition should preserve the learning sequence of the AWS course as closely as possible.
3. The preview course now covers `00-bootstrap` through `25-event-grid-to-function`.
4. The Azure edition targets `miniblue` first so learners do not need Azure accounts unnecessarily.
5. Labs should clearly identify whether they are hands-on, concept-first, CLI-first, or mixed.

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

## Decisions and boundaries

### Authentication model

The primary local auth story is:

- direct Terraform configuration against `miniblue` for validated provider paths
- `azlocal` for validated local control-plane probes where Terraform is not proven
- concept-first real Azure auth guidance for Entra, service principals, managed identities, and OIDC

### Backend naming and isolation

Live validation showed that `miniblue` can create some storage-account control-plane resources, but Terraform backend access still fails when it resolves the standard `blob.core.windows.net` endpoint.

Current decision:

- Labs `05` and `06` are concept-first.
- Do not promise a fully local `backend "azurerm"` path until endpoint compatibility is proven.
- Keep backend examples aligned with the real Azure mental model while naming the local limitation.

### Emulator support boundary

The main risk is not Terraform design, but feature support in the emulator.

Current boundary:

- Early hands-on labs use resource groups, virtual networks, subnets, and NSGs.
- Lab `23` uses `azlocal` Function App control-plane validation, not Terraform Function App apply.
- Lab `24` is concept-first because Entra app registration, service principal, managed identity, and RBAC flows are not locally exposed.
- Lab `25` uses Terraform-validated Event Grid topic creation, but event subscription and Function delivery remain design-first.
- Avoid assuming `azurerm_key_vault`, storage data-plane resources, and `backend "azurerm"` are ready for local-first labs.

### Capstone service family

The capstone should avoid becoming an Azure product survey. It should use a small, repeatable set of services that exercise real Terraform skills.

Current preview decision:

- center the capstone on the validated `modules/app_stack` pattern, environment promotion, policy, CI, ownership, and recovery
- keep service-specific Function App, Entra, and Event Grid topics in Labs `23` through `25`
- avoid making the capstone depend on storage data-plane, Key Vault, or backend flows that are not proven locally

## Suggested next implementation slice

The highest-value next step is:

1. run a learner walkthrough of selected hands-on labs
2. add optional real-Azure appendices where local emulation is intentionally incomplete
3. expand instructor-led materials after the self-paced preview stabilizes
4. revisit `backend "azurerm"` if `miniblue` adds backend-compatible endpoint support

## Current decision for Labs 05 and 06

We are proceeding with a concept-first implementation for Labs `05` and `06`.

That means:

- the labs still teach backend bootstrap and state migration directly
- the labs stay aligned with the AWS course's mental model
- the labs do not pretend the fully local `backend "azurerm"` path is already solved on `miniblue`
