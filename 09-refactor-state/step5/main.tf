resource "azurerm_resource_group" "import_me" {
  name     = "tf-course-import-me-rg"
  location = "East US"

  tags = {
    Lab     = "09"
    Adopted = "true"
  }
}
