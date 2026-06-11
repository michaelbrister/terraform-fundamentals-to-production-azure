resource "azurerm_resource_group" "a" {
  name     = "tf-course-state-a-rg"
  location = "East US"

  tags = {
    Lab  = "13"
    Name = "a"
  }
}

resource "azurerm_resource_group" "b" {
  name     = "tf-course-state-b-rg"
  location = "East US"

  tags = {
    Lab  = "13"
    Name = "b"
  }
}

output "resource_groups" {
  value = {
    a = azurerm_resource_group.a.name
    b = azurerm_resource_group.b.name
  }
}
