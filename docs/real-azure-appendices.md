# Real Azure Appendices

The default Azure edition remains local-first and does not require learners to create Azure accounts.

Use these appendices only when a team is ready to validate the service-extension labs against a real Azure tenant and subscription.

## When To Use Real Azure

Move beyond `miniblue` only when you need to prove behavior that local emulation does not currently cover:

- Azure Functions runtime deployment and invocation
- Microsoft Entra app registrations, service principals, managed identities, and RBAC
- Event Grid event subscriptions and delivery to a Function App
- production-grade logging, retry, dead-letter, and alerting behavior
- real Azure Storage backend migration and locking

## Before You Start

Confirm:

- you have permission to create resources in the target subscription
- you know the tenant and subscription IDs
- you have a cleanup plan and budget guardrail
- credentials are stored in secret storage, not committed files
- the team understands which local assumptions no longer apply
- someone can approve app registrations, role assignments, and production applies

## Appendix Map

| Lab | Appendix | Purpose |
| --- | --- | --- |
| `23-http-api-and-function-app` | `23-http-api-and-function-app/REAL_AZURE_APPENDIX.template.md` | Function App hosting, deployment, app settings, monitoring, and cleanup |
| `24-entra-auth` | `24-entra-auth/REAL_AZURE_APPENDIX.template.md` | Entra app registration, workload identity, RBAC, secret handling, and revocation |
| `25-event-grid-to-function` | `25-event-grid-to-function/REAL_AZURE_APPENDIX.template.md` | Event subscription, Function delivery, retry, dead-letter, observability, and rollback |

## Recommended Validation Order

1. Deploy the smallest possible Function App from Lab `23`.
2. Add the Entra and RBAC model from Lab `24`.
3. Create the Event Grid topic from Lab `25`.
4. Add one event subscription to the Function App.
5. Publish one test event.
6. Confirm function logs, retry behavior, and cleanup.
7. Destroy or deallocate everything not needed after the test.

## Terraform Provider Notes

Real Azure usually requires at least:

- `azurerm` for Azure resources
- `azuread` for Entra objects

Use separate identities or approval gates for:

- planning
- applying to non-production
- applying to production
- app registration administration
- role assignment administration

## Cleanup Standard

Every real-Azure appendix should record:

- resources created
- commands or run links used
- secrets created
- role assignments granted
- resources destroyed
- role assignments removed
- remaining costs or intentionally retained resources

If cleanup cannot be completed immediately, record the owner and expiration date.
