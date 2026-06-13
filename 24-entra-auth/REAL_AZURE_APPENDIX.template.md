# Real Azure Appendix

## Tenant And Subscription

- Tenant ID:
- Subscription ID:
- Resource group:
- Environment:

## Required Permissions

App registration permissions:

- 

Azure RBAC permissions:

- 

Who can approve these permissions:

- 

## Terraform Provider Shape

Expected providers:

- `azurerm`
- `azuread`

Expected resources:

- `azuread_application`
- `azuread_service_principal`
- `azurerm_role_assignment`
- optional `azurerm_user_assigned_identity`

## Secret And Credential Handling

Preferred approach:

- 

Fallback approach:

- 

Values that must never be committed:

- 

## CI/CD

Plan identity:

- 

Apply identity:

- 

Approval requirement:

- 

Audit trail:

- 

## Rollback And Recovery

How to revoke access:

- 

How to rotate credentials:

- 

How to confirm the application still works:

- 
