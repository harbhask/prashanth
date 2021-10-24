keyvault_access_policies = [{
    name                                    = "KV_AccessPol_01"
    keyvault_name                           = "kv-1215000-prod"
    resource_group_name                     = "rg_1215000_prod"
    tenant_id                               = null
    object_id                               = null
    secret_permissions                      = ["backup", "delete", "get", "list", "purge", "recover", "restore", "set"]
    key_permissions                         = []
    certificate_permissions                 = []
}]
