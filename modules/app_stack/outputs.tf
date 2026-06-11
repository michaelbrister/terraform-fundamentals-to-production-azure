output "resource_group_names" {
  value = { for k, v in azurerm_resource_group.rg : k => v.name }
}

output "virtual_network_names" {
  value = { for k, v in azurerm_virtual_network.vnet : k => v.name }
}

output "subnet_names" {
  value = { for k, v in azurerm_subnet.subnet : k => v.name }
}

output "network_security_group_names" {
  value = { for k, v in azurerm_network_security_group.nsg : k => v.name }
}
