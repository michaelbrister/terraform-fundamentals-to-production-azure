module "stack" {
  source      = "../../modules/app_stack"
  env         = "prod"
  name_prefix = "tf-course"
  location    = "East US"

  network_stacks = {
    app = {
      address_space = ["10.40.0.0/16"]
      tags          = { Purpose = "app" }
      subnets = {
        web = {
          address_prefixes = ["10.40.1.0/24"]
        }
        api = {
          address_prefixes = ["10.40.2.0/24"]
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
    shared = {
      address_space = ["10.41.0.0/16"]
      tags          = { Purpose = "shared" }
      subnets = {
        ops = {
          address_prefixes = ["10.41.1.0/24"]
        }
      }
    }
  }
}
