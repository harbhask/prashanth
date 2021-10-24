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

variable "tenant_id" {
//ToDo    description = ""
    type        = string
}

variable "sku_name" {
//ToDo    description = ""
    type        = string
}

variable "enabled_for_disk_encryption" {
//ToDo    description = ""
    type        = bool
}

variable "enabled_for_deployment" {
//ToDo    description = ""
    type        = bool
}

variable "enabled_for_template_deployment" {
//ToDo    description = ""
    type        = bool
}

variable "soft_delete_enabled" {
//ToDo    description = ""
    type        = bool
}

variable "purge_protection_enabled" {
//ToDo    description = ""
    type        = bool
}

variable "tags" {
    type        = map(string)
}
