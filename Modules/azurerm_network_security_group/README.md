# Usage of the module
Author:
* Ajay Kumar <ajay.kumar@icfnext.com>

Version: 0.13.2

Date:    21.10.2021

&nbsp;

## Templates

### terraform .tfvars
```hcl
network_sec_groups = [{
    name                                            = "NSG_01"
    resource_group_name                             = "RG_01"
    location                                        = null
    tags                                            = null
    nsg_rules = [{
        name                                        = "DenyInternetOutbound"
        priority                                    = 4095
        direction                                   = "Outbound"
        access                                      = "Deny"
        protocol                                    = "*"
        source_port_ranges                          = ["*"]
        destination_port_ranges                     = ["*"]
        source_address_prefixes                     = ["*"]
        destination_address_prefixes                = ["Internet"]
    },{
        name                                        = "deny_all_inbound"
        priority                                    = 4096
        direction                                   = "Inbound"
        access                                      = "Deny"
        protocol                                    = "*"
        source_port_ranges                          = ["*"]
        destination_port_ranges                     = ["*"]
        source_address_prefixes                     = ["*"]
        destination_address_prefixes                = ["*"]
    }]
}]
```

### variable .tf
```hcl
variable "network_sec_groups" {
    type = list(object({
        name                                    = string
        resource_group_name                     = string
        location                                = string
        tags                                    = map(string)
        nsg_rules = list(object({
            name                                = string
            priority                            = number
            direction                           = string
            access                              = string
            protocol                            = string
            source_port_ranges                  = list(string)
            destination_port_ranges             = list(string)
            source_address_prefixes             = list(string)
            destination_address_prefixes        = list(string)
        }))
    }))
}
```

### main .tf
```hcl
module "network_sec_group" {
    depends_on                              = [module.resource_group]
    source                                  = "../modules/azurerm_network_security_group"
    for_each                                = { for network_sec_group in toset( var.network_sec_groups ): network_sec_group.name => network_sec_group }
        name                                = each.key
        resource_group_name                 = each.value.resource_group_name
        nsg_rules                           = each.value.nsg_rules
        tags                                = merge(var.overall_tags, each.value.tags)
}
```
