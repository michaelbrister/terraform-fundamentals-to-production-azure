resource "azurerm_resource_group" "consumer" {
  name     = "tfaz-backend-consumer-rg"
  location = "East US"
}

output "consumer_rg" {
  value = azurerm_resource_group.consumer.name
}
