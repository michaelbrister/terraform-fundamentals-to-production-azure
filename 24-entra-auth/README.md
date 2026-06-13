# Lab 24 - Entra Auth

## What this lab teaches you

This lab teaches how Azure identity and access fit around Terraform-managed applications.

You will learn:

- what Microsoft Entra ID owns in an Azure architecture
- the difference between human identity, workload identity, and application identity
- how app registrations, service principals, managed identities, and RBAC relate
- why authentication and authorization are separate design decisions
- what cannot be proven with `miniblue` today

## Scenario

Your team has designed a small HTTP API in Lab `23`.

Now you need an auth model before the API can move toward production. The application should be able to distinguish callers, protect sensitive routes, and access Azure resources without committing secrets.

In real Azure, this usually involves:

- Microsoft Entra app registrations
- service principals or managed identities
- OAuth/OIDC tokens
- Azure RBAC assignments
- application roles or groups
- secret or certificate rotation
- environment-specific identity boundaries

`miniblue` currently exposes local token endpoints for Terraform provider authentication, but it does not expose learner-facing `azlocal ad` or `azlocal identity` commands. That means this lab is intentionally concept-first.

## Lab mode

This is a **concept-first** lab.

You will not create real Entra resources locally. Instead, you will design the auth model, map responsibilities, and write the Terraform shape you would use in real Azure.

## Prerequisites

Complete:

- `15-team-rbac-and-variables`
- `16-governance-sentinel-opa-and-approvals`
- `23-http-api-and-function-app`

You should understand:

- Terraform variable and secret boundaries
- production approval workflows
- the Function App service boundary from Lab `23`

## Local validation boundary

Validated locally:

- Terraform can authenticate to `miniblue` with local fake provider credentials.
- `miniblue` health includes an `identity` service internally.

Not exposed locally:

- `azlocal ad`
- `azlocal identity`
- app registration creation
- service principal creation
- managed identity assignment
- real OAuth/OIDC login flows
- Azure RBAC enforcement

This lab should not pretend a local token endpoint is the same as Microsoft Entra ID. The local provider token path is useful for Terraform testing, but it is not a substitute for real identity design.

## Step 1 - Identify The Identities

Use `IDENTITY_INVENTORY.template.md`.

List each identity involved in the system:

- learner or developer
- pull request reviewer
- CI runner
- Terraform deployer
- Function App runtime
- API caller
- break-glass operator

For each identity, record:

- whether it is human or workload
- what it needs to do
- where credentials live
- who owns rotation or access review
- whether it exists locally, in CI, or only in real Azure

## Step 2 - Separate Authentication From Authorization

Authentication answers:

- Who are you?
- Which tenant issued the token?
- Which app or workload is presenting the token?

Authorization answers:

- What are you allowed to do?
- Which Azure scope applies?
- Which application role or group applies?
- Which route or action is permitted?

Use `AUTH_FLOW_DESIGN.template.md` to sketch the request flow for the Lab `23` HTTP API.

## Step 3 - Design Azure RBAC Scope

For Terraform automation, choose the narrowest practical scope.

Common scopes:

- subscription
- resource group
- individual resource

For a learner project, resource-group scope is usually easier to reason about than subscription-wide access.

Answer:

- Which identity performs Terraform applies?
- Which scope does it need?
- Which built-in role is sufficient?
- Which role would be too broad?
- Who can grant or revoke that role?

## Step 4 - Design Application Access

For API callers, decide whether the application will use:

- app roles
- groups
- scopes
- API keys only for non-production demos
- no auth for a local-only toy endpoint

Answer:

- Who can call the API?
- What claim or group proves access?
- Which routes need stronger authorization?
- How would local development differ from production?

## Step 5 - Sketch The Terraform Shape

Write a Terraform design note. Do not apply it locally.

Depending on the real-Azure design, you might expect resources such as:

- `azuread_application`
- `azuread_service_principal`
- `azuread_application_password`
- `azurerm_user_assigned_identity`
- `azurerm_role_assignment`
- Function App identity and app settings

Answer:

- Which provider owns each resource: `azuread` or `azurerm`?
- Which values are secrets?
- Which outputs are safe?
- Which outputs should never be printed?
- Which resources need lifecycle or rotation planning?

## Step 6 - Design Secret Rotation

Secrets and credentials should have owners and expiry.

Define:

- what rotates
- how often it rotates
- who owns rotation
- where the new value is stored
- how consumers are restarted or refreshed
- what evidence proves rotation succeeded

Prefer managed identity or federated workload identity over long-lived client secrets when the platform supports it.

## Step 7 - Write The Real-Azure Appendix

Use `REAL_AZURE_APPENDIX.template.md`.

Document what a team must do before running this against real Azure:

- tenant access
- app registration permissions
- subscription or resource group scope
- CI secret storage or OIDC federation
- approval process
- audit trail
- rollback plan

For the broader real-Azure service-extension path, see `docs/real-azure-appendices.md`.

## Deliverable

Create an auth design packet with:

- completed `IDENTITY_INVENTORY.template.md`
- completed `AUTH_FLOW_DESIGN.template.md`
- completed `REAL_AZURE_APPENDIX.template.md`
- Terraform resource sketch
- RBAC scope decision
- secret rotation plan
- a short note explaining why this lab is concept-first

## Success criteria

You are done when you can explain:

- why Entra ID cannot be fully emulated by this local lab
- how app registrations, service principals, managed identities, and RBAC differ
- which identity Terraform uses versus which identity the application uses
- why production credentials should not be committed or shared manually
- what would need to change before implementing this in real Azure
