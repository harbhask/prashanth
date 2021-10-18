route_tables = [{
    name                                    = "rt_prod"
    resource_group_name                     = "rg_prod"
    location                                = null
    tags                                    = null
    routes = [{
        name                                = "DEFAULT_0-0-0-0_0"
        address_prefix                      = "0.0.0.0/0"
        next_hop_type                       = "VirtualAppliance"
        next_hop_in_ip_address              = "1.1.1.1/32"
    }]
}]
