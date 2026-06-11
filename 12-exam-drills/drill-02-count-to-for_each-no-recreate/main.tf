# Intentional exam drill: count uses index-based identity.
resource "azurerm_resource_group" "example" {
  count = length(var.names)

  name     = "tf-course-drill-${var.names[count.index]}-rg"
  location = "East US"
}
