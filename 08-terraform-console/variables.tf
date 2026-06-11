variable "env" {
  type    = string
  default = "dev"
}

variable "prefix" {
  type    = string
  default = "tf-course"
}

variable "optional_owner" {
  type    = string
  default = null
}

variable "tag_overrides" {
  type    = map(string)
  default = {}
}

variable "maybe" {
  type    = any
  default = { present = "yes" }
}

variable "subnets" {
  type = list(object({
    name = string
    cidr = string
    zone = string
    tier = string
  }))

  default = [
    { name = "web-a", cidr = "10.10.1.0/24", zone = "a", tier = "web" },
    { name = "web-b", cidr = "10.10.2.0/24", zone = "b", tier = "web" },
    { name = "api-a", cidr = "10.10.11.0/24", zone = "a", tier = "api" },
    { name = "data-a", cidr = "10.10.21.0/24", zone = "a", tier = "data" }
  ]
}

variable "network_stacks" {
  type = map(object({
    address_space = list(string)
    create_nsg    = bool
  }))

  default = {
    app = {
      address_space = ["10.10.0.0/16"]
      create_nsg    = true
    }
    data = {
      address_space = ["10.20.0.0/16"]
      create_nsg    = false
    }
  }
}
