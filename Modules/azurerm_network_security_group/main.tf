data azurerm_resource_group "rg" {
    name                                = var.resource_group_name
}

resource "azurerm_network_security_group" "network_sec_group" {
    name                                = var.name
    resource_group_name                 =                        data.azurerm_resource_group.rg.name
    location                            = coalesce(var.location, data.azurerm_resource_group.rg.location)
    tags                                = var.tags
}

resource "azurerm_network_security_rule" "nsg_rules" {
    for_each                            = { for nsg_rule in toset(var.nsg_rules) : nsg_rule.name => nsg_rule }
        name                            = each.key
        priority                        = each.value.priority
        direction                       = each.value.direction
        access                          = each.value.access
        protocol                        = each.value.protocol
        source_port_range               = [for port_range in each.value.source_port_ranges      : port_range if port_range == "*"] == ["*"] ? "*"  : null
        source_port_ranges              = [for port_range in each.value.source_port_ranges      : port_range if port_range == "*"] == ["*"] ? null : each.value.source_port_ranges
        destination_port_range          = [for port_range in each.value.destination_port_ranges : port_range if port_range == "*"] == ["*"] ? "*"  : null
        destination_port_ranges         = [for port_range in each.value.destination_port_ranges : port_range if port_range == "*"] == ["*"] ? null : each.value.destination_port_ranges
        source_address_prefix           = length(each.value.source_address_prefixes)      == 1 ? each.value.source_address_prefixes[0]      : null
        source_address_prefixes         = length(each.value.source_address_prefixes)      >  1 ? each.value.source_address_prefixes         : null
        destination_address_prefix      = length(each.value.destination_address_prefixes) == 1 ? each.value.destination_address_prefixes[0] : null
        destination_address_prefixes    = length(each.value.destination_address_prefixes) >  1 ? each.value.destination_address_prefixes    : null
        resource_group_name             = azurerm_network_security_group.network_sec_group.resource_group_name
        network_security_group_name     = azurerm_network_security_group.network_sec_group.name
}
