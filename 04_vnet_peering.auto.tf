variable "vnet_peerings" {
    type = list(object({
        bidirectional                       = bool
        resource_group_name                 = string
        tags                                = map(string)
        vnet_source                         = map(string)
        vnet_target                         = map(string)
        peering_outgoing = object({
            name                            = string
            allow_forwarded_traffic         = bool
            allow_gateway_transit           = bool
            use_remote_gateways             = bool
        })
        peering_incoming = object({
            name                            = string
            allow_forwarded_traffic         = bool
            allow_gateway_transit           = bool
            use_remote_gateways             = bool
        })
    }))
}

module "vnet_peering" {
    depends_on                              = [module.resource_group, module.vnet_and_subnet]
    source                                  = "../modules/azurerm_virtual_network_peering"
    for_each                                = { for peering in toset( var.vnet_peerings ): peering.peering_outgoing.name => peering }
        bidirectional                       = each.value.bidirectional
        resource_group_name                 = each.value.resource_group_name
        vnet_source                         = each.value.vnet_source
        vnet_target                         = each.value.vnet_target
        peering_outgoing                    = each.value.peering_outgoing
        peering_incoming                    = each.value.peering_incoming
        tags                                = merge(var.overall_tags, each.value.tags)
}
