resource "azurerm_subnet" "subnet" {
    name                        = var.name
    resource_group_name         = var.resource_group_name
    virtual_network_name        = var.virtual_network_name
    address_prefixes            = var.address_prefixes
    service_endpoints           = var.service_endpoints
}

data "azurerm_network_security_group" "network_sec_group" {
    count                       = var.network_sec_group != null ? 1 : 0
    name                        = var.network_sec_group.name
    resource_group_name         = var.network_sec_group.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "nsg_subnet_association" {
    count                       = var.network_sec_group != null ? 1 : 0
    subnet_id                   = azurerm_subnet.subnet.id
    network_security_group_id   = data.azurerm_network_security_group.network_sec_group[0].id
}

data "azurerm_route_table" "rt" {
    count                       = var.route_table != null ? 1 : 0
    name                        = var.route_table.name
    resource_group_name         = var.route_table.resource_group_name
}

resource "azurerm_subnet_route_table_association" "rt_subnet_association" {
    count                       = var.route_table != null ? 1 : 0
    subnet_id                   = azurerm_subnet.subnet.id
    route_table_id              = data.azurerm_route_table.rt[0].id
}
