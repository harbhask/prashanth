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

variable "sku" {
    description = "Pricing tier of Log Analytics Workspace"
    type        = string
    default     = "PerGB2018"
}

variable "retention_in_days" {
    description = "Possible values range between 30 and 730."
    type        = number
    default     = 90
}

variable "strict_name" {
    description = "Set this one to true in order to use just the name provided, rather than with a suffix"
    type        = bool
    default     = false
}

variable "tags" {
    type        = map(string)
}
