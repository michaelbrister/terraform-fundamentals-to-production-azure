resource "azurerm_resource_group" "oldname" {
  name     = "tf-course-refactor-rg"
  location = "East US"

  tags = {
    Lab  = "09"
    Step = "baseline"
  }
}
