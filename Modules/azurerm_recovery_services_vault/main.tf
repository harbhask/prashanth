data azurerm_resource_group "rg" {
    name                    = var.resource_group_name
}

resource "random_id" "rsv-id" {
    count                   = var.strict_name ? 0 : 1
    keepers = {
        rsv                 = var.name
    }
    byte_length             = 6
}

resource "azurerm_recovery_services_vault" "rsv" {
    name                    = substr("${var.name}g${var.strict_name ? "" : lower(random_id.rsv-id[0].hex)}", 0, 23)
    resource_group_name     =                        data.azurerm_resource_group.rg.name
    location                = coalesce(var.location, data.azurerm_resource_group.rg.location)
    sku                     = var.sku
    soft_delete_enabled     = var.soft_delete
    tags                    = merge(var.tags, { recovery_service_vault = var.name })
}
