resource "azurerm_resource_group" "drift" {
  name     = "tf-course-drift-rg"
  location = "East US"

  tags = {
    Lab      = "10"
    Scenario = "drift"
    Owner    = "terraform"
  }
}
