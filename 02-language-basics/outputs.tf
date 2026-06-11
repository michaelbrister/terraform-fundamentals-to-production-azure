output "resource_group_name" {
  value       = azurerm_resource_group.app.name
  description = "Name of the resource group created by this configuration"
}

output "resource_group_tags" {
  value       = azurerm_resource_group.app.tags
  description = "Tags applied to the resource group"
}
