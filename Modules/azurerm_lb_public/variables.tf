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

variable "frontend_name" {
    type        = string
}

variable "public_ip" {
    type        = map(string)
}

variable "tags" {
    type        = map(string)
}
