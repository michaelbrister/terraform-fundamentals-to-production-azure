locals {
  stack  = "tf-course"
  prefix = "${local.stack}-${var.env}"
}

resource "azurerm_resource_group" "rg" {
  for_each = var.network_stacks

  name     = "${local.prefix}-${each.key}-rg"
  location = "East US"

  tags = merge(
    {
      Environment = var.env
      Stack       = local.stack
      Name        = each.key
    },
    each.value.tags
  )
}

resource "azurerm_virtual_network" "vnet" {
  for_each = var.network_stacks

  name                = "${local.prefix}-${each.key}-vnet"
  address_space       = each.value.address_space
  location            = azurerm_resource_group.rg[each.key].location
  resource_group_name = azurerm_resource_group.rg[each.key].name
}

# Filtered for_each: only stacks with create_nsg=true get an NSG.
resource "azurerm_network_security_group" "nsg" {
  for_each = { for k, v in var.network_stacks : k => v if v.create_nsg }

  name                = "${local.prefix}-${each.key}-nsg"
  location            = azurerm_resource_group.rg[each.key].location
  resource_group_name = azurerm_resource_group.rg[each.key].name
}
