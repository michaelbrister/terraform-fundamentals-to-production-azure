variable "env" {
  type = string
}

variable "name_prefix" {
  type = string
}

variable "location" {
  type    = string
  default = "East US"
}

variable "network_stacks" {
  description = "Reusable network stack definitions for the module"
  type = map(object({
    address_space = list(string)
    tags          = optional(map(string), {})
    subnets = map(object({
      address_prefixes = list(string)
    }))
    network_security_group = optional(object({
      rules = list(object({
        name                       = string
        priority                   = number
        direction                  = string
        access                     = string
        protocol                   = string
        source_port_range          = string
        destination_port_range     = string
        source_address_prefix      = string
        destination_address_prefix = string
      }))
    }))
  }))
  default = {}
}
