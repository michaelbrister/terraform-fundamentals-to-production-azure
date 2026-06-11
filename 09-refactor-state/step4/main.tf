moved {
  from = azurerm_resource_group.newname
  to   = module.resource_group.azurerm_resource_group.this
}

module "resource_group" {
  source = "../modules/resource_group"

  name     = "tf-course-refactor-rg"
  location = "East US"

  tags = {
    Lab  = "09"
    Step = "module-move"
  }
}
