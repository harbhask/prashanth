# Usage of the module
Author:
* Ajay Kumar <ajay.kumar@icfnext.com>

Version: 0.13.2

Date:    21.10.2021

&nbsp;

## Templates

### terraform .tfvars
```hcl
laws = [{
    name                                            = "LAW_01"
    strict_name                                     = false
    resource_group_name                             = "RG_01"
    location                                        = null
    sku                                             = null
    retention_in_days                               = null
    tags                                            = null
}]
```

### variable .tf
```hcl
variable "laws" {
    type = list(object({
        name                                            = string
        strict_name                                     = bool
        resource_group_name                             = string
        location                                        = string
        sku                                             = string
        retention_in_days                               = number
        tags                                            = map(string)
    }))
}
```

### main .tf
```hcl
module "log_analytics_workspace" {
    source                                  = "../modules/azurerm_log_analytics_workspace"
    for_each                                = { for law in toset( var.laws ): law.name => law }
        name                                = each.key
        strict_name                         = each.value.strict_name
        resource_group_name                 = each.value.resource_group_name
        location                            = each.value.location
        sku                                 = each.value.sku
        retention_in_days                   = each.value.retention_in_days
        tags                                = each.value.tags
}
```
