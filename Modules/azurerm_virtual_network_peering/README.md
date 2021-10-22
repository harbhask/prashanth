# Usage of the module
Author:
* Ajay Kumar <ajay.kumar@icfnext.com>

Version: 0.13.2

Date:    21.10.2021

&nbsp;

## Templates

### terraform .tfvars
```hcl
vnet_peerings = [{
    bidirectional                                   = true
    resource_group_name                             = "RG_01"
    tags                                            = null
    vnet_source = {
        subscription_id                             = null
        resource_group_name                         = "RG_01"
        name                                        = "VNET_01"
    }
    vnet_target = {
        subscription_id                             = null
        resource_group_name                         = "RG_02"
        name                                        = "VNET_02"
    }
    peering_outgoing = {
        name                                        = "peering_outgoing"
        allow_forwarded_traffic                     = true
        allow_gateway_transit                       = false
        use_remote_gateways                         = false
    }
    peering_incoming = {
        name                                        = "peering_incoming"
        allow_forwarded_traffic                     = true
        allow_gateway_transit                       = false
        use_remote_gateways                         = false
    }
}]
```

### variable .tf
```hcl
variable "vnet_peerings" {
    type = list(object({
        bidirectional                                   = bool
        resource_group_name                             = string
        tags                                            = map(string)
        vnet_source = map(string)
        vnet_target = map(string)
        peering_outgoing = object({
            name                                        = string
            allow_forwarded_traffic                     = bool
            allow_gateway_transit                       = bool
            use_remote_gateways                         = bool
        })
        peering_incoming = object({
            name                                        = string
            allow_forwarded_traffic                     = bool
            allow_gateway_transit                       = bool
            use_remote_gateways                         = bool
        })
    }))
}
```

### main .tf
```hcl
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
```
