terraform {
  required_version = ">= 1.5.0"
}

locals {
  tags_common = merge(
    {
      ManagedBy   = "terraform"
      Stack       = var.prefix
      Environment = var.env
    },
    var.tag_overrides
  )

  subnets_by_zone = {
    for zone in distinct([for subnet in var.subnets : subnet.zone]) :
    zone => sort([for subnet in var.subnets : subnet.name if subnet.zone == zone])
  }

  subnets_by_tier = {
    for tier in distinct([for subnet in var.subnets : subnet.tier]) :
    tier => sort([for subnet in var.subnets : subnet.name if subnet.tier == tier])
  }

  nsg_enabled_stacks = {
    for name, stack in var.network_stacks : name => stack
    if stack.create_nsg
  }
}
