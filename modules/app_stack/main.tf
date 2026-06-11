locals {
  common_tags = {
    Environment = var.env
    Stack       = var.name_prefix
    ManagedBy   = "terraform"
  }

  subnet_list = flatten([
    for stack_name, stack in var.network_stacks : [
      for subnet_name, subnet in stack.subnets : {
        key         = "${stack_name}|${subnet_name}"
        stack_name  = stack_name
        subnet_name = subnet_name
        subnet      = subnet
      }
    ]
  ])

  subnet_map = {
    for item in local.subnet_list : item.key => item
  }

  nsg_map = {
    for stack_name, stack in var.network_stacks : stack_name => stack
    if try(stack.network_security_group, null) != null
  }
}

resource "azurerm_resource_group" "rg" {
  for_each = var.network_stacks

  name     = "${var.name_prefix}-${var.env}-${each.key}-rg"
  location = var.location
  tags     = merge(local.common_tags, each.value.tags, { Name = each.key })
}

resource "azurerm_virtual_network" "vnet" {
  for_each = var.network_stacks

  name                = "${var.name_prefix}-${var.env}-${each.key}-vnet"
  address_space       = each.value.address_space
  location            = azurerm_resource_group.rg[each.key].location
  resource_group_name = azurerm_resource_group.rg[each.key].name
  tags                = merge(local.common_tags, each.value.tags, { Name = each.key })
}

resource "azurerm_subnet" "subnet" {
  for_each = local.subnet_map

  name                 = each.value.subnet_name
  resource_group_name  = azurerm_resource_group.rg[each.value.stack_name].name
  virtual_network_name = azurerm_virtual_network.vnet[each.value.stack_name].name
  address_prefixes     = each.value.subnet.address_prefixes
}

resource "azurerm_network_security_group" "nsg" {
  for_each = local.nsg_map

  name                = "${var.name_prefix}-${var.env}-${each.key}-nsg"
  location            = azurerm_resource_group.rg[each.key].location
  resource_group_name = azurerm_resource_group.rg[each.key].name
  tags                = merge(local.common_tags, each.value.tags, { Name = each.key })

  dynamic "security_rule" {
    for_each = each.value.network_security_group.rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}
