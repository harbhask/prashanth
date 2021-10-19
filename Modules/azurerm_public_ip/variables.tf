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

variable "allocation_method" {
    type        = string
}

variable "ip_version" {
    type        = string
    default     = "IPv4"
}

variable "tags" {
    type        = map(string)
}

variable "sku" {
    type        = string
}
