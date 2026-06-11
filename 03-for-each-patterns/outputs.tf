output "resource_group_names" {
  value       = { for k, v in azurerm_resource_group.rg : k => v.name }
  description = "Resource group names keyed by network stack"
}

output "virtual_network_names" {
  value       = { for k, v in azurerm_virtual_network.vnet : k => v.name }
  description = "Virtual network names keyed by network stack"
}

output "network_security_group_names" {
  value       = { for k, v in azurerm_network_security_group.nsg : k => v.name }
  description = "Network security group names for stacks that enabled them"
}
