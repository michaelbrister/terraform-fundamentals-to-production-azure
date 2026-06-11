output "resource_group_name" {
  value       = azurerm_resource_group.demo.name
  description = "Name of the resource group created by this Terraform configuration"
}
