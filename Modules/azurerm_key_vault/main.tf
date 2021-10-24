data "azurerm_client_config" "current" { }

data "azurerm_resource_group" "rg" {
    name                                = var.resource_group_name
}

resource "random_id" "kv-id" {
    count                               = var.strict_name ? 0 : 1
    keepers = {
        keyvault                        = var.name
    }
    byte_length                         = 6
}

resource "azurerm_key_vault" "kv" {
    name                                = substr("${var.name}g${var.strict_name ? "" : lower(random_id.kv-id[0].hex)}", 0, 23)
    resource_group_name                 =                        data.azurerm_resource_group.rg.name
    location                            = coalesce(var.location, data.azurerm_resource_group.rg.location)
    tenant_id                           = var.tenant_id == null ? data.azurerm_client_config.current.tenant_id : var.tenant_id
    sku_name                            = var.sku_name
    enabled_for_disk_encryption         = var.enabled_for_disk_encryption
    enabled_for_deployment              = var.enabled_for_deployment
    enabled_for_template_deployment     = var.enabled_for_template_deployment
    soft_delete_enabled                 = var.soft_delete_enabled
    purge_protection_enabled            = var.purge_protection_enabled
    tags                                = merge(var.tags, { key_vault = var.name })
}
