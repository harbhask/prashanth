
variable "keyvault_name" {
    type        = string
}

variable "resource_group_name" {
    type        = string
}

variable "tenant_id" {
    type        = string
}

variable "object_id" {
    type        = string
}

variable "secret_permissions" {
    type        = list(string)
}

variable "key_permissions" {
    type        = list(string)
}

variable "certificate_permissions" {
    type        = list(string)
}
