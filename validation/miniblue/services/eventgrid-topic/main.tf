resource "azurerm_resource_group" "this" {
  name     = "tf-course-eventgrid-validation-rg"
  location = "eastus"

  tags = {
    Environment = "dev"
    ManagedBy   = "terraform"
    Name        = "eventgrid-validation"
    Stack       = "tf-course"
  }
}

resource "azurerm_eventgrid_topic" "this" {
  name                = "tfcourseegvalidation"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  tags = {
    Environment = "dev"
    ManagedBy   = "terraform"
    Name        = "eventgrid-validation"
    Stack       = "tf-course"
  }
}

