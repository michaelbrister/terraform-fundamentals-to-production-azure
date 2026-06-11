resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

locals {
  suffix              = random_string.suffix.result
  resource_group_name = "tfaz-${local.suffix}-rg"
  storage_name        = "tfaz${local.suffix}"
  vnet_name           = "tfaz-${local.suffix}-vnet"
  nsg_name            = "tfaz-${local.suffix}-nsg"
  vault_name          = "tfaz-${local.suffix}-kv"
}

resource "azurerm_resource_group" "main" {
  name     = local.resource_group_name
  location = "East US"
}

resource "azurerm_storage_account" "main" {
  name                     = local.storage_name
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "state" {
  name                  = "state"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}

resource "azurerm_virtual_network" "main" {
  name                = local.vnet_name
  address_space       = ["10.42.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "app" {
  name                 = "app"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.42.1.0/24"]
}

resource "azurerm_network_security_group" "main" {
  name                = local.nsg_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = "allow-https-in"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_key_vault" "main" {
  name                       = local.vault_name
  location                   = azurerm_resource_group.main.location
  resource_group_name        = azurerm_resource_group.main.name
  tenant_id                  = "00000000-0000-0000-0000-000000000001"
  sku_name                   = "standard"
  soft_delete_retention_days = 7
}

resource "azurerm_key_vault_secret" "example" {
  name         = "example-secret"
  value        = "training-secret"
  key_vault_id = azurerm_key_vault.main.id
}
