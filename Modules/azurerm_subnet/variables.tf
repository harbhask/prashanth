variable "name" {
    type        = string
}

variable "resource_group_name" {
    type        = string
}

variable "location" {
    type        = string
    default     = ""
}

variable "virtual_network_name" {
    type        = string
}

variable "address_prefixes" {
    type        = list(string)
}

variable "service_endpoints" {
    type        = list(string)
}

variable "network_sec_group" {
    type        = map(string)
}

variable "route_table" {
    type        = map(string)
}
