variable "networks" {
  type = map(object({
    subnets = list(string)
  }))

  default = {
    app = {
      subnets = ["web", "api"]
    }
  }
}
