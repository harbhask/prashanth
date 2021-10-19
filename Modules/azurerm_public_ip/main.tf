data azurerm_resource_group "rg" {
    name                        = var.resource_group_name
}

resource "azurerm_public_ip" "pub_ip" {
    name                        = var.name
    resource_group_name         =                        data.azurerm_resource_group.rg.name
    location                    = coalesce(var.location, data.azurerm_resource_group.rg.location)
    allocation_method           = var.allocation_method
    ip_version                  = var.ip_version
    tags                        = var.tags
    sku                         = var.sku
}
