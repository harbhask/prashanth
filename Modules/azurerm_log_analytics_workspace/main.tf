data azurerm_resource_group "rg" {
    name                    = var.resource_group_name
}

resource "random_id" "kv-id" {
    count                               = var.strict_name ? 0 : 1
    keepers = {
        keyvault                        = var.name
    }
    byte_length                         = 6
}

resource "azurerm_log_analytics_workspace" "law" {
    name                    = substr("${var.name}g${var.strict_name ? "" : lower(random_id.kv-id[0].hex)}", 0, 23)
    resource_group_name     = data.azurerm_resource_group.rg.name
    location                = coalesce(var.location, data.azurerm_resource_group.rg.location)
    sku                     = var.sku
    retention_in_days       = var.retention_in_days
    tags                    = merge(var.tags, { log_analytics_workspace = var.name })
}
