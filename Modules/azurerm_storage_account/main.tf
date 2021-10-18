data azurerm_resource_group "rg" {
    name                        = var.resource_group_name
}

resource "random_id" "sa-id" {
    count                       = var.strict_name ? 0 : 1
    keepers = {
        storage_account         = var.name
    }
    byte_length                 = 6
}

resource "azurerm_storage_account" "storage_account" {
    name                        = substr("${var.name}g${var.strict_name ? "" : lower(random_id.sa-id[0].hex)}", 0, 23)
    resource_group_name         = data.azurerm_resource_group.rg.name
    location                    = coalesce(var.location, data.azurerm_resource_group.rg.location)
    account_tier                = var.account_tier
    account_replication_type    = var.account_replication_type
    account_kind                = var.account_kind
    tags                        = merge(var.tags, { storage_account_name = var.name })
}
