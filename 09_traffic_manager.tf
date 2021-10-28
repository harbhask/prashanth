variable "traffic_manager" {
    type = list(object({
        profile_name                                = string
        resource_group_name                         = string
        routing_method                              = string
        ttl                                         = string
        monitor_config = object({
            protocol                     = string,
            port                         = number,
            path                         = string,
            interval_in_seconds          = number,
            timeout_in_seconds           = number,
            tolerated_number_of_failures = number
        })
        endpoint = object({
            names                      = list(string),
            ip_names                   = list(string),
            ip_resource_groups         = list(string),
            type                       = string,
            priorities                 = list(number)
        })
    }))
}

module "traffic_manager" {
    source                                  = "./Modules/azurerm_traffic_manager"
    for_each                                = { for tfmng in toset( var.traffic_manager ): tfmng.profile_name => tfmng }
        profile_name                        = each.key
        resource_group_name                 = each.value.resource_group_name
        routing_method                      = each.value.routing_method
        ttl                                 = each.value.ttl
        monitor_config                      = each.value.monitor_config
        endpoint                            = each.value.endpoint                            = each.value.tags

}
