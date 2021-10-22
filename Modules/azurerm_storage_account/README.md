# Usage of the module
Author:
* Ajay Kumar <ajay.kumar@icfnext.com>

Version: 0.13.2

Date:    21.10.2021

&nbsp;

## Templates

### terraform .tfvars
```hcl
storage_accounts = [{
    name                                            = "StroageAcc_01"
    resource_group_name                             = "RG_01"
    location                                        = null
    strict_name                                     = false
    account_tier_storage                            = "Standard"
    account_replication_type_storage                = "LRS"
    account_kind_storage                            = "StorageV2"
    tags                                            = null
}]
```

### variable .tf
```hcl
variable "storage_accounts" {
    type = list(object({
        name                                = string
        strict_name                         = bool
        resource_group_name                 = string
        location                            = string
        account_tier_storage                = string
        account_replication_type_storage    = string
        account_kind_storage                = string
        tags                                = map(string)
    }))
}
```

### main .tf
```hcl
module "storage_account" {
    depends_on                      = [azurerm_resource_group.resource_group]
    source                          = "../modules/azurerm_storage_account"
    for_each                        = { for sa in toset( var.storage_accounts ): sa.name => sa }
        name                        = each.key
        strict_name                 = each.value.strict_name
        resource_group_name         = each.value.resource_group_name
        account_tier                = each.value.account_tier_storage
        account_replication_type    = each.value.account_replication_type_storage
        account_kind                = each.value.account_kind_storage
        tags                        = merge(var.overall_tags, each.value.tags)
}
```
