resource "azurerm_resource_group" "newname" {
  name     = "tf-course-refactor-rg"
  location = "East US"

  tags = {
    Lab  = "09"
    Step = "state-moved"
  }
}
