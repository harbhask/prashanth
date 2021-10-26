variable "mysql_server" {
    type = list(object({
        name                                        = string
        tags                                        = map(string)
        resource_group_name                         = string
        location                                    = string
        vnet = object({
            name                                    = string
            resource_group_name                     = string
            subnet_name                             = string
        })
        mysql_data = object({
            version                                 = string
            ssl_enforcement                         = bool
            admin_user                              = string
            admin_pwd                               = string
            sku_name                                = string
            storage_mb                              = number
            backup_retention_days                   = number
            geo_redundant_backup                    = bool
            vnet_rule_name                          = string
        })
    }))
}

module "mysql_server" {
    source                                  = "./Modules/azurerm_mysql_server"
    for_each                                = { for mysql in toset( var.mysql_server ): mysql.name => mysql }
        name                                = each.key
        resource_group_name                 = each.value.resource_group_name
        location                            = each.value.location
        vnet                                = each.value.vnet
        mysql_data                          = each.value.mysql_data
        tags                                = each.value.tags
}
