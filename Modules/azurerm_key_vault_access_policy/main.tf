
data "azurerm_client_config" "current" { }

module "kv" {
    source                  = "../../../0.13/d/azurerm_key_vault"
    name                    = var.keyvault_name
    resource_group_name     = var.resource_group_name
}

resource "azurerm_key_vault_access_policy" "kv_policy" {
    key_vault_id                = module.kv.id
    tenant_id                   = var.tenant_id == null ? data.azurerm_client_config.current.tenant_id : var.tenant_id
    object_id                   = var.object_id == null ? data.azurerm_client_config.current.object_id : var.object_id
    secret_permissions          = var.secret_permissions
    key_permissions             = var.key_permissions
    certificate_permissions     = var.certificate_permissions
}
