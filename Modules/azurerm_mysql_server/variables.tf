###########################################################
# Subnet
###########################################################
variable "vnet" {
    type        = map(string)
}

###########################################################
# RG
###########################################################
variable "resource_group_name" {
  description = "The resource group name"
  type        = string
}

variable "location" {
  description = "The resource group location"
  type        = string
}


###########################################################
# MySQL
###########################################################
variable "name" {
  description = "The name of MYSQL server "
  type        = string
}

variable "mysql_data" {
    description = "All parameters to setup the VM."
    type        = object({
        version                    = string
        ssl_enforcement            = bool
        admin_user                 = string
        admin_pwd                  = string
        sku_name                   = string
        storage_mb                 = number
        backup_retention_days      = number
        geo_redundant_backup       = bool
        vnet_rule_name             = string
    })
}



variable "tags" {
  description = "The tags to be applied in each resource"
  type        = map
}