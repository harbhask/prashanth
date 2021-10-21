variable "log_analytics_workspaces" {
    type = list(object({
        name                                = string
        strict_name                         = bool
        resource_group_name                 = string
        location                            = string
        sku                                 = string
        retention_in_days                   = number
        tags                                = map(string)
    }))
}

module "log_analytics_workspace" {
    source                                  = "../modules/azurerm_log_analytics_workspace"
    for_each                                = { for law in toset( var.log_analytics_workspaces ): law.name => law }
        name                                = each.key
        strict_name                         = each.value.strict_name
        resource_group_name                 = each.value.resource_group_name
        location                            = each.value.location
        sku                                 = each.value.sku
        retention_in_days                   = each.value.retention_in_days
        tags                                = each.value.tags
}
