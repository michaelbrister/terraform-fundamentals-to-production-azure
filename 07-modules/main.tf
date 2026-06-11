module "stack" {
  source      = "../modules/app_stack"
  env         = "dev"
  name_prefix = "tf-course"
  location    = "East US"

  network_stacks = {
    app = {
      address_space = ["10.10.0.0/16"]
      tags          = { Purpose = "app" }
      subnets = {
        web = {
          address_prefixes = ["10.10.1.0/24"]
        }
        api = {
          address_prefixes = ["10.10.2.0/24"]
        }
      }
      network_security_group = {
        rules = [
          {
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
        ]
      }
    }
    data = {
      address_space = ["10.20.0.0/16"]
      tags          = { Purpose = "data" }
      subnets = {
        db = {
          address_prefixes = ["10.20.1.0/24"]
        }
      }
    }
  }
}
