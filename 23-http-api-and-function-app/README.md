# Lab 23 - HTTP API And Function App

## What this lab teaches you

This lab introduces Azure Functions as the service boundary behind an HTTP API.

You will learn:

- what a Function App represents in Azure
- how HTTP-triggered serverless APIs fit into an Azure architecture
- what `miniblue` can validate locally today
- where local emulation stops before real Azure deployment begins
- how to document the Terraform design before the provider path is proven

## Scenario

Your team wants a small HTTP API for an internal application.

In real Azure, the API would likely use:

- a Function App
- an App Service plan or consumption-style hosting model
- a storage account for runtime state
- application settings
- deployed function code
- optional API Management or Front Door in front of the function

In this local-first course, `miniblue` currently validates the Function App control-plane shape through `azlocal functionapp create/list`. The full Terraform path is intentionally not used yet because Function App resources usually require several supporting resources and packaging behavior that have not been proven locally.

## Lab mode

This is a **concept/CLI-first** lab.

You will use `azlocal` to create and inspect the local Function App resource, then write the Terraform design you would use once the local provider path or real Azure path is available.

## Prerequisites

Complete:

- `00-bootstrap`
- `01-local-basics`
- `05-backend-bootstrap`
- `07-modules`
- `16-governance-sentinel-opa-and-approvals`

You should have:

- Terraform available
- `miniblue` installed
- `azlocal` available
- the local `miniblue` endpoint running

## Local validation boundary

Validated locally:

- `azlocal functionapp create`
- `azlocal functionapp list`
- resource group create/delete

Not yet validated locally:

- `azurerm_linux_function_app`
- storage-account-backed Function runtime flows
- deploying function code packages
- invoking a real HTTP trigger through a local Function runtime
- production identity, RBAC, and auth wiring

That boundary is the lesson. Good Terraform engineers do not turn an unvalidated emulator behavior into learner-facing certainty.

## Step 1 - Start miniblue

Start the emulator:

```bash
miniblue
```

In another terminal, verify health:

```bash
curl -s http://localhost:4566/health
```

You should see a JSON response with local Azure-style services.

## Step 2 - Create A Resource Group

Create a temporary group for this lab:

```bash
azlocal group create --name tf-course-lab23-rg --location eastus
```

Record:

- the resource group name
- the location
- whether the command created or reused the group

## Step 3 - Create A Function App

Create the local Function App control-plane resource:

```bash
azlocal functionapp create \
  --resource-group tf-course-lab23-rg \
  --name tfcourselab23func \
  --location eastus
```

This validates that the local emulator accepts the Function App resource shape.

It does not prove:

- code deployment
- HTTP trigger execution
- Azure Functions host behavior
- Terraform support for the full resource graph

## Step 4 - Inspect The Function App

List Function Apps in the resource group:

```bash
azlocal functionapp list --resource-group tf-course-lab23-rg
```

Answer:

- What is the resource type?
- Which fields look like Azure control-plane metadata?
- Which runtime details are missing?
- What would you need before calling this a deployed API?

## Step 5 - Design The HTTP API

Use `HTTP_API_DESIGN.template.md`.

Define:

- route
- method
- request shape
- response shape
- required app settings
- secret handling strategy
- expected logs and metrics
- local validation evidence
- real Azure deployment notes

Keep the design intentionally small. The goal is to model the service boundary, not build a complete application platform.

If your team is ready to validate this outside `miniblue`, complete `REAL_AZURE_APPENDIX.template.md` before creating resources in a real Azure subscription.

## Step 6 - Sketch The Terraform Shape

Write a short Terraform design note. Do not apply it locally yet.

Include the resources you would expect in real Azure:

- `azurerm_resource_group`
- `azurerm_service_plan`
- `azurerm_storage_account`
- `azurerm_linux_function_app`
- application settings
- optional identity
- optional API gateway/front-door resource

Answer:

- Which resources are control plane?
- Which resources are runtime dependencies?
- Which values are secrets?
- Which settings should be variables?
- Which outputs would another team need?

## Step 7 - Cleanup

Delete the Function App:

```bash
azlocal functionapp delete \
  --resource-group tf-course-lab23-rg \
  --name tfcourselab23func
```

Delete the resource group:

```bash
azlocal group delete --name tf-course-lab23-rg
```

If deleting the resource group removes child resources first, a later Function App delete may report `ResourceNotFound`. Treat that as acceptable cleanup evidence when the final resource group delete succeeds.

## Deliverable

Create a lab packet with:

- completed `HTTP_API_DESIGN.template.md`
- completed `COMMAND_LOG.template.md`
- completed `REAL_AZURE_APPENDIX.template.md` if running against real Azure
- a short Terraform resource sketch
- a paragraph explaining why this lab is not yet Terraform hands-on

For the broader real-Azure service-extension path, see `docs/real-azure-appendices.md`.

## Success criteria

You are done when you can explain:

- the difference between a Function App resource and a deployed function
- why local control-plane validation is useful but incomplete
- which supporting resources a Terraform Function App deployment usually needs
- why secrets and app settings need ownership boundaries
- what must be validated before this becomes a fully hands-on Terraform lab
