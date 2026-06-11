locals {
  unstable_subnets = flatten([
    for network_name, network in var.networks : [
      for index, subnet_name in network.subnets : {
        key          = "${network_name}-${index}"
        network_name = network_name
        subnet_name  = subnet_name
      }
    ]
  ])

  stable_subnets = flatten([
    for network_name, network in var.networks : [
      for subnet_name in network.subnets : {
        key          = "${network_name}|${subnet_name}"
        network_name = network_name
        subnet_name  = subnet_name
      }
    ]
  ])
}

output "unstable_keys" {
  value = [for subnet in local.unstable_subnets : subnet.key]
}

output "stable_keys" {
  value = [for subnet in local.stable_subnets : subnet.key]
}
