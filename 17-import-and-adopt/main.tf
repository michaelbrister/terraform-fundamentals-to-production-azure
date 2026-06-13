locals {
  common_tags = {
    Environment = "dev"
    ManagedBy   = "terraform"
    Stack       = "tf-course"
    Adoption    = "lab17"
  }
}

resource "azurerm_resource_group" "adopted" {
  name     = "tf-course-adopt-rg"
  location = "eastus"

  tags = local.common_tags
}
