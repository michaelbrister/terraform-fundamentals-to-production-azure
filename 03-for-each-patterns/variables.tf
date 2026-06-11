variable "env" {
  type    = string
  default = "dev"
}

variable "network_stacks" {
  description = "Map of network stack configs"
  type = map(object({
    create_nsg    = bool
    address_space = list(string)
    tags          = map(string)
  }))
}
