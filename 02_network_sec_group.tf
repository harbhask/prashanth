variable "network_sec_groups" {
    type = list(object({
        name                                = string
        resource_group_name                 = string
        location                            = string
        tags                                = map(string)
        nsg_rules = list(object({
            name                            = string
            priority                        = number
            direction                       = string
            access                          = string
            protocol                        = string
            source_port_ranges              = list(string)
            destination_port_ranges         = list(string)
            source_address_prefixes         = list(string)
            destination_address_prefixes    = list(string)
        }))
    }))
}

module "network_sec_group" {
    depends_on                              = [module.resource_group]
    source                                  = "../modules/azurerm_network_security_group"
    for_each                                = { for network_sec_group in toset( var.network_sec_groups ): network_sec_group.name => network_sec_group }
        name                                = each.key
        resource_group_name                 = each.value.resource_group_name
        nsg_rules                           = each.value.nsg_rules
        tags                                = merge(var.overall_tags, each.value.tags)
}
