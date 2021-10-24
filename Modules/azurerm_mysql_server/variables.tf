###########################################################
# Subnet
###########################################################
variable "subnet_id" {
  description = "The subnet ID"
  type        = string
}

###########################################################
# RG
###########################################################
variable "resource_group_names" {
  description = "The resource group name"
  type        = string
}

variable "location" {
  description = "The resource group location"
  type        = string
}

###########################################################
# Key Vault
###########################################################

variable "keyvault_name" {
  description = "The Azure Key Vault Name"
  type        = string
}

variable "keyvault_resource_group_name" {
  description = "The Azure Key Vault Resource Group Name"
  type        = string
}

###########################################################
# MySQL
###########################################################

variable "dslab_mysql_name" {
  description = "The MySQL server name"
  type        = string
}

variable "dslab_mysql_version" {
  description = "The MySQL server version"
  type        = string
}

variable "dslab_mysql_ssl_enforcement" {
  description = "The MySQL server SSL enforcement status"
  type        = string
}

variable "azure_mysql_admin_user" {
  description = "The MySQL server admin username"
  type        = string
}

variable "dslab_mysql_vnet_rule_name" {
  description = "The MySQL server VNet Rule Name"
  type        = string
}

####################
# MySQL - SKU
####################

variable "dslab_mysql_sku_name" {
  description = "The MySQL server SKU Name"
  type        = string
}

variable "dslab_mysql_sku_capacity" {
  description = "The MySQL server SKU capacity"
  type        = number
}

variable "dslab_mysql_sku_tier" {
  description = "The MySQL server SKU tier"
  type        = string
}

variable "dslab_mysql_sku_family" {
  description = "The MySQL server SKU Family name"
  type        = string
}

####################
# MySQL - Storage Profile
####################

variable "dslab_mysql_sp_storage_mb" {
  description = "The MySQL server storage profile size"
  type        = number
}

variable "dslab_mysql_sp_backup_retention_days" {
  description = "The MySQL server storage retention days"
  type        = number
}

variable "dslab_mysql_sp_geo_redundant_backup" {
  description = "The MySQL server backup status"
  type        = string
}

variable "tags" {
  description = "The tags to be applied in each resource"
  type        = map
}
