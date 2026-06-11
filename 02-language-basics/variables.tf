variable "env" {
  type    = string
  default = "dev"

  validation {
    condition     = contains(["dev", "stage", "prod"], var.env)
    error_message = "env must be dev, stage, or prod"
  }
}

variable "location" {
  type    = string
  default = "East US"
}

variable "workload_name" {
  type    = string
  default = "app"
}
