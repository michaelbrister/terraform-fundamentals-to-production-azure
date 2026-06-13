# Real Azure Appendix

## Tenant And Subscription

- Tenant ID:
- Subscription ID:
- Resource group:
- Location:
- Environment:

## Expected Resources

Minimum resources:

- `azurerm_resource_group`
- `azurerm_service_plan`
- `azurerm_storage_account`
- `azurerm_linux_function_app`

Optional resources:

- `azurerm_application_insights`
- `azurerm_log_analytics_workspace`
- API Management, Front Door, or another HTTP edge
- user-assigned managed identity

## Runtime And Deployment

Function runtime:

-

Deployment method:

-

Package or source artifact:

-

Required app settings:

-

Settings that must be secrets:

-

## Validation

Before production, prove:

- Function App deploys successfully
- HTTP trigger can be invoked
- expected response shape is returned
- logs include request or correlation identifiers
- app settings are present without exposing secrets
- deployment can be repeated without manual portal fixes

## Security

Authentication requirement:

-

Authorization requirement:

-

Managed identity:

-

Network restrictions:

-

## Operations

Dashboards:

-

Alerts:

-

Runbook:

-

## Rollback And Cleanup

Rollback method:

-

Resources to destroy after validation:

-

Resources intentionally retained:

-
