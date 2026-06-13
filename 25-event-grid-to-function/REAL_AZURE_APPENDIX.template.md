# Real Azure Appendix

## Resources

Expected resources:

- `azurerm_eventgrid_topic`
- `azurerm_eventgrid_event_subscription`
- `azurerm_linux_function_app`
- Function App hosting dependencies
- optional dead-letter storage

## Delivery Validation

Before production, prove:

- event publish succeeds
- subscription filters route expected events
- Function handler receives the event
- malformed events fail safely
- retries behave as expected
- dead-letter path works
- logs include correlation data

## Security

Authentication and authorization:

- 

Managed identity or endpoint protection:

- 

Secrets:

- 

## Operations

Dashboards:

- 

Alerts:

- 

Runbook:

- 

## Rollback

Disable subscription:

- 

Stop producer:

- 

Restore previous handler:

- 
