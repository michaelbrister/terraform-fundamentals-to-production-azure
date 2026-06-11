resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

locals {
  suffix              = random_string.suffix.result
  resource_group_name = "tfaz-backend-${local.suffix}-rg"
  storage_name        = "tfazback${local.suffix}"
}

resource "azurerm_resource_group" "backend" {
  name     = local.resource_group_name
  location = "East US"
}

resource "azurerm_storage_account" "backend" {
  name                     = local.storage_name
  resource_group_name      = azurerm_resource_group.backend.name
  location                 = azurerm_resource_group.backend.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.backend.name
  container_access_type = "private"
}
