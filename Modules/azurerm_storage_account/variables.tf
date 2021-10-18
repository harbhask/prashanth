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

variable "tags" {
    type        = map(string)
}

variable "account_tier" {
    description = "Valid options are Standard and Premium. For FileStorage accounts only Premium is valid."
    type        = string
    default     = "Standard"
}

variable "account_replication_type" {
    description = "Valid options are LRS, GRS, RAGRS and ZRS."
    type        = string
    default     = "LRS"
}

variable "account_kind" {
    description = "Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to Storage. Only V2 storage account are supported with retention policy"
    type        = string
    default     = "StorageV2"
}

variable "strict_name" {
    description = "Set this one to true in order to use just the name provided, rather than with a suffix"
    type        = bool
    default     = false
}
