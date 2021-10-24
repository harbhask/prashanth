###########################################################
# Key Vault
###########################################################

# Get Key Vault
data "azurerm_key_vault" "keyvault" {
  name                = var.keyvault_name
  resource_group_name = var.keyvault_resource_group_name
}

# Get secret
data "azurerm_key_vault_secret" "azure_mysql_admin_pass" {
  name         = var.dslab_mysql_name
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

###########################################################
# Azure MySQL User Database
###########################################################

resource "azurerm_mysql_server" "dslab_mysql" {
  name                         = var.dslab_mysql_name
  location                     = var.location
  resource_group_name          = var.resource_group_names
  sku_name                     = var.dslab_mysql_sku_name
  storage_mb                   = var.dslab_mysql_sp_storage_mb
  backup_retention_days        = var.dslab_mysql_sp_backup_retention_days
  geo_redundant_backup_enabled = var.dslab_mysql_sp_geo_redundant_backup

  administrator_login          = var.azure_mysql_admin_user
  administrator_login_password = data.azurerm_key_vault_secret.azure_mysql_admin_pass.value
  version                      = var.dslab_mysql_version
  ssl_enforcement_enabled      = var.dslab_mysql_ssl_enforcement

  tags = var.tags
}

###########################################################
# Azure MySQL VNet Rule
###########################################################

resource "azurerm_mysql_virtual_network_rule" "dslab_mysql_vnetrule" {
  name                = var.dslab_mysql_vnet_rule_name
  resource_group_name = var.resource_group_names
  server_name         = azurerm_mysql_server.dslab_mysql.name
  subnet_id           = var.subnet_id
}
