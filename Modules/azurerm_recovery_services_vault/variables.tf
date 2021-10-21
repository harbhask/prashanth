variable "name" {
    type        = string
}

variable "strict_name" {
    description = "Set this one to true in order to use just the name provided, rather than with a suffix"
    type        = bool
    default     = false
}

variable "resource_group_name" {
    type        = string
}

variable "location" {
    type        = string
    default     = ""
}

variable "tags" {
    type        = map(string)
}

variable "sku" {
//ToDo    description = ""
    type        = string
}

variable "soft_delete" {
//ToDo    description = ""
    type        = bool
}
