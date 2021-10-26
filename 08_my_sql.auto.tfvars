mysql_server = [{
    name                                        = 
    tags                                            = null
    resource_group_name                             = 
    location                                        = null
    vnet = {
        name                                        = 
        resource_group_name                         = 
        subnet_name                                 = 
    }
    mysql_data = {
        version                                     = string
        ssl_enforcement                             = bool
        admin_user                                  = string
        admin_pwd                                   = string
        sku_name                                    = string
        storage_mb                                  = number
        backup_retention_days                       = number
        geo_redundant_backup                        = bool
        vnet_rule_name                              = string
    }
}]
