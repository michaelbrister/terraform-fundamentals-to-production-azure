output "network_security_group_names" {
  value       = { for k, v in azurerm_network_security_group.nsg : k => v.name }
  description = "Network security group names keyed by logical name"
}
