variable "profile_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "routing_method" {
  type    = string
  default = "Priority"
}

variable "ttl" {
  type    = number
  default = 60
}

variable "monitor_config" {
  type = object({
    protocol                     = string,
    port                         = number,
    path                         = string,
    interval_in_seconds          = number,
    timeout_in_seconds           = number,
    tolerated_number_of_failures = number
  })
  default = {
    protocol                     = "http",
    port                         = 80,
    path                         = "/",
    interval_in_seconds          = 30,
    timeout_in_seconds           = 9,
    tolerated_number_of_failures = 3
  }
}

variable "endpoint" {
  type = object({
    names                      = list(string),
    ip_names                   = list(string),
    ip_resource_groups         = list(string),
    type                       = string,
    priorities                 = list(number)
  })
}
