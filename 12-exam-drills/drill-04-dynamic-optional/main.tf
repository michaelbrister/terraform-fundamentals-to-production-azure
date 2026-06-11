variable "rules" {
  type = list(object({
    name     = string
    priority = number
    port     = string
    enabled  = bool
  }))

  default = [
    { name = "https", priority = 100, port = "443", enabled = true },
    { name = "debug", priority = 200, port = "9000", enabled = false }
  ]
}

resource "azurerm_resource_group" "drill" {
  name     = "tf-course-dynamic-drill-rg"
  location = "East US"
}

resource "azurerm_network_security_group" "drill" {
  name                = "tf-course-dynamic-drill-nsg"
  location            = azurerm_resource_group.drill.location
  resource_group_name = azurerm_resource_group.drill.name

  dynamic "security_rule" {
    for_each = [for rule in var.rules : rule if rule.enabled]
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value.port
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}
