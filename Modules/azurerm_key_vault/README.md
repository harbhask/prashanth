# Usage of the module
Author:
* Ajay Kumar <ajay.kumar@icfnext.com>

Version: 0.13.2

Date:    21.10.2021

&nbsp;

## Templates

### terraform .tfvars
```hcl
keyvaults = [{
    name                        = "KV_01"
    strict_name                 = false
    resource_group_name         = "RG_01"
    sku                         = "standard"
    tenant_id                   = "00000000-0000-0000-0000-000000000000"
    disk_encryption             = true
    vm_deployment               = true
    arm_template_deployment     = true
    soft_delete                 = false
    purge_protection            = true
    tags                        = null
}]
```

### variable .tf
```hcl
variable "keyvaults" {
    type = list(object({
        name                                = string
        strict_name                         = bool
        resource_group_name                 = string
        location                            = string
        sku                                 = string
        tenant_id                           = string
        disk_encryption                     = bool
        vm_deployment                       = bool
        arm_template_deployment             = bool
        soft_delete                         = bool
        purge_protection                    = bool
        tags                                = map(string)
    }))
}
```

### main .tf
```hcl
module "key_vault" {
    depends_on                              = [module.resource_group]
    source                                  = "../../modules/0.13/r/azurerm_key_vault"
    for_each                                = { for kv in toset( var.keyvaults ): kv.name => kv }
        resource_group_name                 = each.value.resource_group_name
        location                            = module.resource_group[each.value.resource_group_name].location
        name                                = each.key
        tenant_id                           = each.value.tenant_id
        sku_name                            = each.value.sku
        enabled_for_disk_encryption         = each.value.disk_encryption
        enabled_for_deployment              = each.value.vm_deployment
        enabled_for_template_deployment     = each.value.arm_template_deployment
        soft_delete_enabled                 = each.value.soft_delete
        purge_protection_enabled            = each.value.purge_protection
        tags                                = merge(var.overall_tags, each.value.tags)
}
```
