# Usage of the module
Author:
* Ajay Kumar <ajay.kumar@icfnext.com>

Version: 0.13.2

Date:    21.10.2021

&nbsp;

## Templates

### terraform .tfvars
```hcl
resource_group_names = [{
    name                                            = "RG_01",
    location                                        = "southCentralUs",
    tags                                            = null
},{
    name                                            = "RG_02",
    location                                        = "southCentralUs",
    tags                                            = null
}]
```

### variable .tf
```hcl
variable "resource_group_names" {
    type = list(object({
        name                                = string
        location                            = string
        tags                                = map(string)
    }))
}
```

### main .tf
```hcl
module "resource_group" {
    source                                  = "../modules/azurerm_resource_group"
    for_each                                = { for rg in toset( var.resource_group_names ): rg.name => rg }
        name                                = each.key
        location                            = each.value.location
        tags                                = merge(var.overall_tags, each.value.tags)
}
```
