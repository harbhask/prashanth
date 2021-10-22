# Usage of the module
Author:
* Ajay Kumar <ajay.kumar@icfnext.com>

Version: 0.13.2

Date:    21.10.2021

&nbsp;

## Templates

### terraform .tfvars
```hcl
route_tables = [{
    name                                            = "RT_01"
    resource_group_name                             = "RG_01"
    location                                        = null
    tags                                            = null
    routes = [{
        name                                        = "DEFAULT_0-0-0-0_0"
        address_prefix                              = "0.0.0.0/0"
        next_hop_type                               = "VirtualAppliance"
        next_hop_in_ip_address                      = "a.b.c.d"
    }]
}]
```

### variable .tf
```hcl
variable "route_tables" {
    type = list(object({
        name                                    = string
        resource_group_name                     = string
        location                                = string
        tags                                    = map(string)
        routes = list(object({
            name                                = string
            address_prefix                      = string
            next_hop_type                       = string
            next_hop_in_ip_address              = string
        }))
    }))
}
```

### main .tf
```hcl

module "routeTable" {
    depends_on                              = [module.resource_group]
    source                                  = "../modules/azurerm_route_table"
    for_each                                = { for rt in toset( var.route_tables ): rt.name => rt }
        name                                = each.key
        resource_group_name                 = each.value.resource_group_name
        tags                                = merge(var.overall_tags, each.value.tags)
        routes                              = each.value.routes
}
```
