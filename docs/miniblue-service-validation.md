# miniblue Service Validation Matrix

**Validated on:** 2026-06-13
**miniblue version observed:** `0.7.0`
**Terraform version observed:** `1.15.6` via `mise`

## Goal

Before building Azure service extension Labs `23`-`25`, validate what can run locally without requiring learners to create Azure accounts.

The decision rule:

- Use hands-on Terraform when the `azurerm` resource path validates.
- Use hands-on `azlocal` when the local service behavior validates but Terraform provider support is not proven.
- Use concept-first docs when the local emulator surface is missing or too shallow.
- Add a real-Azure appendix only when the lab would otherwise teach a misleading local substitute.

## Current Results

| Candidate | Local evidence | Terraform evidence | Course decision |
| --- | --- | --- | --- |
| Resource groups | `azlocal group create` works | `azurerm_resource_group` works | Safe hands-on |
| Virtual networks/subnets/NSGs | Previous apply smoke passed | `azurerm_virtual_network`, `azurerm_subnet`, `azurerm_network_security_group` work | Safe hands-on |
| Storage queue | `azlocal queue create`, `message send` work | Not yet validated through `azurerm_storage_queue` | Use `azlocal` only unless Terraform path validates |
| Storage account/blob/backend | ARM create partially works; data-plane endpoint mismatch noted | `backend "azurerm"` and storage-heavy provider flows are not reliable locally | Do not anchor labs on this path |
| Function App | `azlocal functionapp create/list` works | Not yet validated through `azurerm_linux_function_app` or related resources | Lab `23` should be concept/CLI-first unless Terraform path validates |
| Event Grid topic | `azlocal eventgrid topic create/list` works | `azurerm_eventgrid_topic` apply/destroy passed in `validation/miniblue/services/eventgrid-topic` | Safe hands-on for topic creation |
| Entra/auth | No `azlocal ad` or `azlocal identity` command exposed; health lists `identity` only | Not validated | Lab `24` should be concept-first |
| Event Grid to Function | Component create paths exist separately | Event Grid topic is Terraform-validated; end-to-end subscription/delivery is not validated | Lab `25` can be mixed: topic hands-on, delivery design-first |

## Commands Used

Start `miniblue`:

```bash
miniblue
```

Health:

```bash
curl -s http://localhost:4566/health
```

Temporary resource group:

```bash
azlocal group create --name tf-course-services-rg --location eastus
```

Function App probe:

```bash
azlocal functionapp create --resource-group tf-course-services-rg --name tfcoursefunc --location eastus
azlocal functionapp list --resource-group tf-course-services-rg
```

Event Grid probe:

```bash
azlocal eventgrid topic create --resource-group tf-course-services-rg --name tfcourseegtopic --location eastus
azlocal eventgrid topic list --resource-group tf-course-services-rg
```

Queue probe:

```bash
azlocal queue create --account tfcoursestorage --name tfcoursequeue
azlocal queue message send --account tfcoursestorage --queue tfcoursequeue --body hello
```

Identity probe:

```bash
azlocal ad --help
azlocal identity --help
```

Result:

- no Entra/AD command exists
- `identity` is not exposed as an `azlocal` command in this version

## Recommended Lab Direction

### Lab 23 - HTTP API And Function App

Recommended mode:

- concept/CLI-first

Reason:

- `azlocal functionapp create/list` works
- Terraform Function App resources usually require service plans, storage accounts, app settings, and packaging flows
- the local Terraform path is not yet proven

### Lab 24 - Entra Auth

Recommended mode:

- concept-first

Reason:

- no local Entra-style CLI surface is exposed
- real Entra app registrations, service principals, federated credentials, and RBAC require real Azure identity systems

### Lab 25 - Event Grid To Function

Recommended mode:

- mixed

Reason:

- Event Grid topic creation works through `azlocal` and Terraform
- Function App creation works through `azlocal`
- event subscription and event delivery still need validation before the full end-to-end flow can be hands-on

## Validation Roots

Terraform validation roots:

- `validation/miniblue/services/eventgrid-topic`

Run the Event Grid topic validation root:

```bash
terraform -chdir=validation/miniblue/services/eventgrid-topic init -backend=false
terraform -chdir=validation/miniblue/services/eventgrid-topic validate
terraform -chdir=validation/miniblue/services/eventgrid-topic apply -auto-approve
terraform -chdir=validation/miniblue/services/eventgrid-topic destroy -auto-approve
```
