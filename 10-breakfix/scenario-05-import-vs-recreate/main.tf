resource "azurerm_resource_group" "adopt" {
  name     = "tf-course-adopt-rg"
  location = "East US"

  tags = {
    Lab      = "10"
    Scenario = "import-vs-recreate"
  }
}
