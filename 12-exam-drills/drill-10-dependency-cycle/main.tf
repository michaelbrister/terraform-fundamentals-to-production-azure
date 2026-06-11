terraform {
  required_version = ">= 1.5.0"
}

locals {
  a = local.b
  b = local.a
}

output "cycle" {
  value = local.a
}
