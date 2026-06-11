resource "azurerm_resource_group" "partial" {
  name     = "tf-course-partial-rg"
  location = "East US"

  tags = {
    Lab      = "10"
    Scenario = "partial-ops"
  }
}
