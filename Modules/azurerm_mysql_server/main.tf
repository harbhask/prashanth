#####################################################################
#                                                                   #
#         Data Sources (Subnet)                                     #
#                                                                   #
#####################################################################
data "azurerm_subnet" "subnet" {
    name                            = var.vnet.subnet_name
    virtual_network_name            = var.vnet.name
    resource_group_name             = var.vnet.resource_group_name
}

###########################################################
# Azure MySQL User Database
###########################################################

resource "azurerm_mysql_server" "mysql" {
  name                              = var.name
  location                          = var.location
  resource_group_name               = var.resource_group_name
  sku_name                          = var.mysql_data.sku_name
  storage_mb                        = var.mysql_data.storage_mb
  backup_retention_days             = var.mysql_data.backup_retention_days
  geo_redundant_backup_enabled      = var.mysql_data.geo_redundant_backup
  administrator_login               = var.mysql_data.admin_user
  administrator_login_password      = var.mysql_data.admin_pwd
  version                           = var.mysql_data.version
  ssl_enforcement_enabled           = var.mysql_data.ssl_enforcement

  tags = var.tags
}

###########################################################
# Azure MySQL VNet Rule
###########################################################

resource "azurerm_mysql_virtual_network_rule" "vnetrule" {
  name                             = var.mysql_data.vnet_rule_name
  resource_group_name              = var.resource_group_name
  server_name                      = azurerm_mysql_server.mysql.name
  subnet_id                        = data.azurerm_subnet.subnet.id
}