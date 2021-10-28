resource "random_id" "server" {
  keepers = {
    azi_id = 1
  }
  byte_length = 8
}

data "azurerm_public_ip" "endpoint_pips" {
  count               = length(var.endpoint.ip_names)
  name                = var.endpoint.ip_names[count.index]
  resource_group_name = var.endpoint.ip_resource_groups[count.index]
}

resource "azurerm_traffic_manager_profile" "traffic_manager_profile" {
  name                = var.profile_name
  resource_group_name = var.resource_group_name

  traffic_routing_method = var.traffic_routing_method

  dns_config {
    relative_name = random_id.server.hex
    ttl           = var.ttl
  }

  monitor_config {
    protocol                     = var.monitor_config.protocol
    port                         = var.monitor_config.port
    path                         = var.monitor_config.path
    interval_in_seconds          = var.monitor_config.interval_in_seconds
    timeout_in_seconds           = var.monitor_config.timeout_in_seconds
    tolerated_number_of_failures = var.monitor_config.tolerated_number_of_failures
  }
}

resource "azurerm_traffic_manager_endpoint" "endpoint" {
  count               = length(var.endpoint.names)
  name                = var.endpoint.names[count.index]
  resource_group_name = azurerm_traffic_manager_profile.traffic_manager_profile.resource_group_name
  profile_name        = azurerm_traffic_manager_profile.traffic_manager_profile.name
  target_resource_id  = data.azurerm_public_ip.endpoint_pips[count.index].id
  type                = var.endpoint.type
  priority            = length(var.endpoint.priorities) < length(var.endpoint.names) ? (var.endpoint.priorities[0] + count.index) : var.endpoint.priorities[count.index]
}
