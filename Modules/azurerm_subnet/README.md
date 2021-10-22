# Usage of the module
Author:
* Ajay Kumar <ajay.kumar@icfnext.com>

Version: 0.13.2

Date:    21.10.2021

&nbsp;

## Templates

### terraform .tfvars
```hcl
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
```

### variable .tf
```hcl
variable "networks" {
    type = list(object({
        name                            = string
        address_prefixes                = list(string)
        service_endpoints               = list(string)
        route_table                     = map(string)
        network_sec_group               = map(string)
    }))
}
```

### main .tf
```hcl
module "subnet" {
    source                      = "../azurerm_subnet"
    for_each                    = { for subnet in toset(var.subnets) : subnet.name => subnet }
        name                    = each.key
        resource_group_name     = data.azurerm_resource_group.rg.name
        virtual_network_name    = azurerm_virtual_network.vnet.name
        address_prefixes        = each.value.address_prefixes
        service_endpoints       = each.value.service_endpoints
        route_table             = each.value.route_table
        network_sec_group       = each.value.network_sec_group
}
```
