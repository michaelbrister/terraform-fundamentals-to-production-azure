locals {
  prefix = "tf-course-${var.env}"
}

resource "azurerm_resource_group" "rg" {
  name     = "${local.prefix}-dynamic-rg"
  location = "East US"
}

resource "azurerm_network_security_group" "nsg" {
  for_each = var.security_groups

  name                = "${local.prefix}-${each.key}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  dynamic "security_rule" {
    for_each = each.value.rules
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
