output "topic_name" {
  value = azurerm_eventgrid_topic.this.name
}

output "topic_endpoint" {
  value = azurerm_eventgrid_topic.this.endpoint
}

