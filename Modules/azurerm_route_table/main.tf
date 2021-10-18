data azurerm_resource_group "rg" {
    name                                = var.resource_group_name
}

resource "azurerm_route_table" "rt" {
    name                                = var.name
    resource_group_name                 =                        data.azurerm_resource_group.rg.name
    location                            = coalesce(var.location, data.azurerm_resource_group.rg.location)
    disable_bgp_route_propagation       = false
    tags                                = var.tags
}

resource "azurerm_route" "route" {
    for_each                    = { for route in toset(var.routes) : route.name => route }
        name                    = each.key
        resource_group_name       = data.azurerm_resource_group.rg.name
        route_table_name          = azurerm_route_table.rt.name
        address_prefix            = each.value.address_prefix
        next_hop_type             = each.value.next_hop_type
        next_hop_in_ip_address    = each.value.next_hop_in_ip_address
}
