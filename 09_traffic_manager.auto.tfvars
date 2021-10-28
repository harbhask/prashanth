traffic_manager = [{
        profile_name                                = string
        resource_group_name                         = string
        routing_method                              = string
        ttl                                         = string
        monitor_config = {
            protocol                                = string,
            port                                    = number,
            path                                    = string,
            interval_in_seconds                     = number,
            timeout_in_seconds                      = number,
            tolerated_number_of_failures            = number
        }
        endpoint = {
            names                                   = list(string),
            ip_names                                = list(string),
            ip_resource_groups                      = list(string),
            type                                    = string,
            priorities                              = list(number)
        }
}]
