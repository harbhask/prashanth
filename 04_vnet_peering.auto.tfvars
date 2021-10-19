vnet_peerings = [{
    bidirectional                           = true
    resource_group_name                     = "rg_prod"
    tags                                    = null
    vnet_source = {
        subscription_id                     = null
        resource_group_name                 = ""
        name                                = ""
    }
    vnet_target = {
        subscription_id                     = null
        resource_group_name                 = ""
        name                                = ""
    }
    peering_outgoing = {
        name                                = ""
        allow_forwarded_traffic             = true
        allow_gateway_transit               = false
        use_remote_gateways                 = false
    }
    peering_incoming = {
        name                                = ""
        allow_forwarded_traffic             = true
        allow_gateway_transit               = false
        use_remote_gateways                 = false
    }
}]
