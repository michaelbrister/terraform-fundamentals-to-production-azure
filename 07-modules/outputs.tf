output "resource_groups" {
  value       = module.stack.resource_group_names
  description = "Resource group names returned by the module"
}

output "virtual_networks" {
  value       = module.stack.virtual_network_names
  description = "Virtual network names returned by the module"
}

output "subnets" {
  value       = module.stack.subnet_names
  description = "Subnet names returned by the module"
}

output "network_security_groups" {
  value       = module.stack.network_security_group_names
  description = "Network security group names returned by the module"
}
