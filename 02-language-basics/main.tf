locals {
  prefix = "tf-course-${var.env}"
  tags = {
    Environment = var.env
    Workload    = var.workload_name
    ManagedBy   = "terraform"
  }
}

resource "azurerm_resource_group" "app" {
  name     = "${local.prefix}-${var.workload_name}-rg"
  location = var.location
  tags     = local.tags
}
