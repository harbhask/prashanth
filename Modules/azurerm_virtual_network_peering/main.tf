data "azurerm_client_config" "current" { }

locals {
    vnet_source_subscription_id = var.vnet_source.subscription_id == null ? data.azurerm_client_config.current.subscription_id : var.vnet_source.subscription_id
    vnet_target_subscription_id = var.vnet_target.subscription_id == null ? data.azurerm_client_config.current.subscription_id : var.vnet_target.subscription_id

    vnet_source_resource_id = "/subscriptions/${local.vnet_source_subscription_id}/resourceGroups/${var.vnet_source.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.vnet_source.name}"
    vnet_target_resource_id = "/subscriptions/${local.vnet_target_subscription_id}/resourceGroups/${var.vnet_target.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.vnet_target.name}"
}

resource "azurerm_virtual_network_peering" "vnet1_to_vnet2_peering" {
    name                            = var.peering_outgoing.name
    virtual_network_name            = var.vnet_source.name
    resource_group_name             = var.vnet_source.resource_group_name
    allow_forwarded_traffic         = var.peering_outgoing.allow_forwarded_traffic
    allow_gateway_transit           = var.peering_outgoing.allow_gateway_transit
    use_remote_gateways             = var.peering_outgoing.use_remote_gateways
    remote_virtual_network_id       = local.vnet_target_resource_id
}

resource "azurerm_virtual_network_peering" "vnet2_to_vnet1_peering" {
    count                           = var.bidirectional ? 1 : 0
    name                            = var.peering_incoming.name
    virtual_network_name            = var.vnet_target.name
    resource_group_name             = var.vnet_target.resource_group_name
    allow_forwarded_traffic         = var.peering_incoming.allow_forwarded_traffic
    allow_gateway_transit           = var.peering_incoming.allow_gateway_transit
    use_remote_gateways             = var.peering_incoming.use_remote_gateways
    remote_virtual_network_id       = local.vnet_source_resource_id
}
