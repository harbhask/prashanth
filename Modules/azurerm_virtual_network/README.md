# Usage of the module
Author:
* Ajay Kumar <ajay.kumar@icfnext.com>

Version: 0.13.2

Date:    21.10.2021

&nbsp;

## Templates

### terraform .tfvars
```hcl
networks = [{
    name                                            = "VNET_01"
    resource_group_name                             = "RG_01"
    location                                        = null
    address_space                                   = ["a.b.c.d/cidr"]
    dns_servers                                     = ["a.b.c.d", "a.b.c.d"]
    tags                                            = null // { key1 = value, key2 = value }
    subnets = [{
        name                                        = "Subnet_01"
        address_prefixes                            = ["a.b.c.d/cidr"]
        service_endpoints                           = null // ["Microsoft.Storage", "Microsoft.Sql"]
        route_table = {
            name                                    = "RT_01"
            resource_group_name                     = "RG_01"
        }
        network_sec_group = {
            name                                    = "NSG_01"
            resource_group_name                     = "RG_01"
        }
    },
    {
        name                                        = "AzureFirewallSubnet"
        address_prefixes                            = ["a.b.c.d/cidr"]
        service_endpoints                           = null // ["Microsoft.Storage", "Microsoft.Sql"]
        route_table                                 = null
        network_sec_group                           = null
    }]
}]
```

### variable .tf
```hcl
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
        }))
    }))
}
```

### main .tf
```hcl
module "vnet_and_subnet" {
    depends_on                              = [module.resource_group, module.routeTable, module.network_sec_group ]
    source                                  = "../modules/azurerm_virtual_network"
    for_each                                = { for network in toset( var.networks ): network.name => network }
        name                                = each.key
        resource_group_name                 = each.value.resource_group_name
        address_space                       = each.value.address_space
        dns_servers                         = each.value.dns_servers
        subnets                             = each.value.subnets
        tags                                = merge(var.overall_tags, each.value.tags)
}
```
