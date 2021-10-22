# Usage of the module
Author:
* Ajay Kumar <ajay.kumar@icfnext.com>

Version: 0.13.2

Date:    21.10.2021

&nbsp;

## Templates

### terraform .tfvars
```hcl
public_ips = [{
    name                                        = "PIP_01"
    resource_group_name                         = "RG_01"
    location                                    = null
    allocation_method                           = "Static"
    sku                                         = "Basic"
    ip_version                                  = "IPv4"
    tags                                        = null
}]
```

### variable .tf
```hcl
variable "public_ips" {
    type = list(object({
        name                                        = string
        resource_group_name                         = string
        location                                    = string
        allocation_method                           = string
        sku                                         = string
        ip_version                                  = string
        tags                                        = map(string)
    }))
}
```

### main .tf
```hcl
module "pub_ip" {
    source                      = "../azurerm_public_ip"
    name                        = var.public_ip.name
    resource_group_name         =                        data.azurerm_resource_group.rg.name
    location                    = coalesce(var.location, data.azurerm_resource_group.rg.location)
    allocation_method           = var.public_ip.allocation_method
    sku                         = var.public_ip.sku
    tags                        = var.tags
}
```
