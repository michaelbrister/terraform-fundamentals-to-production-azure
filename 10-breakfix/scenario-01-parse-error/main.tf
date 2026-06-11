resource "azurerm_resource_group" "bad" {
  name     = "tf-course-parse-error-rg"
  location = "East US"

  tags = {
    Lab = "10" Scenario = "parse-error"
  }
}
