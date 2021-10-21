variable "recovery_services_vaults" {
    type = list(object({
        name                                = string
        strict_name                         = bool
        resource_group_name                 = string
        location                            = string
        sku                                 = string
        soft_delete                         = bool
        tags                                = map(string)
    }))
}

module "recovery_services_vault" {
    depends_on                              = [module.resource_group]
    source                                  = "../modules/azurerm_recovery_services_vault"
    for_each                                = { for rsv in toset( var.recovery_services_vaults ): rsv.name => rsv }
        name                                = each.key
        resource_group_name                 = each.value.resource_group_name
        location                            = coalesce(each.value.location, module.resource_group[each.value.resource_group_name].location)
        sku                                 = each.value.sku
        soft_delete                         = each.value.soft_delete
        tags                                = merge(var.overall_tags, each.value.tags)
}
