data azurerm_resource_group "rg" {
    name                        = var.resource_group_name
}

module "pub_ip" {
    source                      = "../azurerm_public_ip"
    name                        = var.public_ip.name
    resource_group_name         =                        data.azurerm_resource_group.rg.name
    location                    = coalesce(var.location, data.azurerm_resource_group.rg.location)
    allocation_method           = var.public_ip.allocation_method
    sku                         = var.public_ip.sku
    tags                        = var.tags
}

resource "azurerm_lb" "lb" {
    name                        = var.name
    resource_group_name         =                        data.azurerm_resource_group.rg.name
    location                    = coalesce(var.location, data.azurerm_resource_group.rg.location)
    tags                        = var.tags

    frontend_ip_configuration {
        name                    = var.frontend_name
        public_ip_address_id    = module.pub_ip.id
    }
}
