# BAD PATTERN: count ties identity to numeric indexes.
resource "azurerm_resource_group" "bad" {
  count = length(var.names)

  name     = "tf-course-count-${var.names[count.index]}-rg"
  location = "East US"
}

output "resource_groups" {
  value = [for rg in azurerm_resource_group.bad : rg.name]
}
