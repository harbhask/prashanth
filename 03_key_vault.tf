variable "keyvaults" {
    type = list(object({
        name                                = string
        strict_name                         = bool
        resource_group_name                 = string
        location                            = string
        sku                                 = string
        tenant_id                           = string
        disk_encryption                     = bool
        vm_deployment                       = bool
        arm_template_deployment             = bool
        soft_delete                         = bool
        purge_protection                    = bool
        tags                                = map(string)
    }))
}

module "keyvault" {
    depends_on                              = [module.resource_group]
    source                                  = "./Modules/azurerm_key_vault"
    for_each                                = { for kv in toset( var.keyvaults ): kv.name => kv }
        resource_group_name                 = each.value.resource_group_name
        location                            = module.resource_group[each.value.resource_group_name].location
        name                                = each.key
        tenant_id                           = each.value.tenant_id
        sku_name                            = each.value.sku
        enabled_for_disk_encryption         = each.value.disk_encryption
        enabled_for_deployment              = each.value.vm_deployment
        enabled_for_template_deployment     = each.value.arm_template_deployment
        soft_delete_enabled                 = each.value.soft_delete
        purge_protection_enabled            = each.value.purge_protection
        tags                                = merge(var.overall_tags, each.value.tags)
}
