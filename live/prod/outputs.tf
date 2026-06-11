output "resource_groups" {
  value = module.stack.resource_group_names
}

output "virtual_networks" {
  value = module.stack.virtual_network_names
}

output "subnets" {
  value = module.stack.subnet_names
}

output "network_security_groups" {
  value = module.stack.network_security_group_names
}
