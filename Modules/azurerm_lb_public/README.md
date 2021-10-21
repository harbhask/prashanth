# Usage of the module
Author:
* Ajay Kumar <ajay.kumar@icfnext.com>

Version: 0.13.2

Date:    21.10.2021

&nbsp;

## Templates

### terraform .tfvars
```hcl
public_lbs = [{
    name                                            = "LB_01"
    resource_group_name                             = "RG_01"
    location                                        = null
    frontend_name                                   = "FrontEnd"
    public_ip = {
        name                                        = "PIP_01"
        allocation_method                           = "Static"
        sku                                         = "Basic"
    }
    tags                                            = null
},{
    name                                            = "LB_02"
    resource_group_name                             = "RG_01"
    location                                        = null
    frontend_name                                   = "FrontEnd"
    public_ip = {
        name                                        = "PIP_02"
        allocation_method                           = "Static"
        sku                                         = "Basic"
    }
    tags                                            = null
}]
```

### variable .tf
```hcl
variable "public_lbs" {
    type = list(object({
        name                                            = string
        resource_group_name                             = string
        location                                        = string
        frontend_name                                   = string
        public_ip                                       = map(string)
        tags                                            = map(string)
    }))
}
```

### main .tf
```hcl
module "public_lbs" {
    source                          =  "../modules/azurerm_lb_public"
    for_each                        = { for lb in toset(var.public_lbs) : lb.name => lb }
        name                        = each.key
        resource_group_name         = each.value.resource_group_name
        location                    = each.value.location
        frontend_name               = each.value.frontend_name
        public_ip                   = each.value.public_ip
        tags                        = merge(var.overall_tags, each.value.tags)
}
```
