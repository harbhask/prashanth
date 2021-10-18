variable "route_tables" {
    type = list(object({
        name                                = string
        resource_group_name                 = string
        location                            = string
        tags                                = map(string)
        routes = list(object({
            name                            = string
            address_prefix                  = string
            next_hop_type                   = string
            next_hop_in_ip_address          = string
        }))
    }))
}

module "routeTable" {
    depends_on                              = [module.resource_group]
    source                                  = "../../modules/0.13/r/azurerm_route_table"
    for_each                                = { for rt in toset( var.route_tables ): rt.name => rt }
        name                                = each.key
        resource_group_name                 = each.value.resource_group_name
        tags                                = merge(var.overall_tags, each.value.tags)
        routes                              = each.value.routes
}
