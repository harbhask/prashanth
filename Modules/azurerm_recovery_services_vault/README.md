# Usage of the module
Author:
* Ajay Kumar <ajay.kumar@icfnext.com>

Version: 0.13.2

Date:    21.10.2021

&nbsp;

## Templates

### terraform .tfvars
```hcl
recovery_services_vaults = [{
    name                                            = "rv-1215000-prod"
    strict_name                                     = false
    resource_group_name                             = "rg_1215000_prod"
    location                                        = null
    sku                                             = "standard"
    soft_delete                                     = false
    tags                                            = null
}]
```

### variable .tf
```hcl
variable "recovery_services_vaults" {
    type = list(object({
        name                                = string
        strict_name                         = bool
        resource_group_name                 = string
        location                            = string
        sku                                 = string
        soft_delete                         = bool
        tags                                = map(string)
    }))
}
```

### main .tf
```hcl
module "recovery_services_vault" {
    depends_on                              = [module.resource_group]
    source                                  = "../modules/azurerm_recovery_services_vault"
    for_each                                = { for rsv in toset( var.recovery_services_vaults ): rsv.name => rsv }
        name                                = each.key
        resource_group_name                 = each.value.resource_group_name
        location                            = coalesce(each.value.location, module.resource_group[each.value.resource_group_name].location)
        sku                                 = each.value.sku
        soft_delete                         = each.value.soft_delete
        tags                                = merge(var.overall_tags, each.value.tags)
}
```
