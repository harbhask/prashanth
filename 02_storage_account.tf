variable "storage_accounts" {
    type = list(object({
        name                            = string
        strict_name                     = bool
        resource_group_name             = string
        location                        = string
        account_tier                    = string
        account_replication_type        = string
        account_kind                    = string
        tags                            = map(string)
    }))
}

module "storage_account" {
    depends_on                          = [module.resource_group]
    source                              = "../../modules/0.13/r/azurerm_storage_account"
    for_each                            = { for sa in toset( var.storage_accounts ): sa.name => sa }
        name                            = each.key
        strict_name                     = each.value.strict_name
        resource_group_name             = each.value.resource_group_name
        account_tier                    = each.value.account_tier
        account_replication_type        = each.value.account_replication_type
        account_kind                    = each.value.account_kind
        tags                            = merge(var.overall_tags, each.value.tags)
}
