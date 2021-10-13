variable "networks" {
    type = list(object({
        name                                = string
        resource_group_name                 = string
        location                            = string
        address_space                       = list(string)
        dns_servers                         = list(string)
        tags                                = map(string)
        subnets = list(object({
            name                            = string
            address_prefixes                = list(string)
            service_endpoints               = list(string)
            route_table                     = map(string)
            network_sec_group               = map(string)
        }))
    }))
}

module "vnet_and_subnet" {
    depends_on                              = [module.resource_group]
    source                                  = "../modules/azurerm_virtual_network"
    for_each                                = { for network in toset( var.networks ): network.name => network }
        name                                = each.key
        resource_group_name                 = each.value.resource_group_name
        address_space                       = each.value.address_space
        dns_servers                         = each.value.dns_servers
        subnets                             = each.value.subnets
        tags                                = merge(var.overall_tags, each.value.tags)
}
