variable "keyvault_access_policies" {
    type = list(object({
        name                                = string
        keyvault_name                       = string
        resource_group_name                 = string
        tenant_id                           = string
        object_id                           = string
        secret_permissions                  = list(string)
        key_permissions                     = list(string)
        certificate_permissions             = list(string)
    }))
}

module "keyvault_access_policy" {
    depends_on                              = [module.resource_group, module.keyvault]
    source                                  = "./Modules/azurerm_key_vault_access_policy"
    for_each                                = { for policy in toset( var.keyvault_access_policies ): policy.name => policy }
        keyvault_name                       = each.value.keyvault_name
        resource_group_name                 = each.value.resource_group_name
        tenant_id                           = each.value.tenant_id
        object_id                           = each.value.object_id
        secret_permissions                  = each.value.secret_permissions
        key_permissions                     = each.value.key_permissions
        certificate_permissions             = each.value.certificate_permissions
}
