# Usage of the module
Author:
* Ajay Kumar <ajay.kumar@icfnext.com>

Version: 0.13.2

Date:    21.10.2021

&nbsp;

## Templates

### terraform .tfvars
```hcl
keyvault_access_policies = [{
    keyvault_name                                   = "KV_01"
    resource_group_name                             = "RG_01"
    tenant_id                                       = null
    object_id                                       = null
    secret_permissions                              = ["backup", "delete", "get", "list", "purge", "recover", "restore", "set"]
    key_permissions                                 = []
    certificate_permissions                         = []
}]
```

### variable .tf
```hcl
variable "keyvault_access_policies" {
    type = list(object({
        keyvault_name                       = string
        resource_group_name                 = string
        tenant_id                           = string
        object_id                           = string
        secret_permissions                  = list(string)
        key_permissions                     = list(string)
        certificate_permissions             = list(string)
    }))
}
```

### main .tf
```hcl
module "key_vault_access_policy" {
    depends_on                              = [module.resource_group, module.key_vault]
    source                                  = "../../modules/0.13/r/azurerm_key_vault_access_policy"
    for_each                                = { for kvap in toset( var.keyvault_access_policies ): kvap.keyvault_name => kvap }
        keyvault_name                       = each.key
        resource_group_name                 = each.value.resource_group_name
        tenant_id                           = each.value.tenant_id
        object_id                           = each.value.object_id
        secret_permissions                  = each.value.secret_permissions
        key_permissions                     = each.value.key_permissions
        certificate_permissions             = each.value.certificate_permissions
}
```
