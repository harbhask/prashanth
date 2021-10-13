networks = [{
    name                                            = "prodvnet"
    resource_group_name                             = "rg_prod"
    location                                        = null
    address_space                                   = ["10.215.0.0/24"]
    dns_servers                                     = null
    tags                                            = null
    subnets = [{
        name                                        = "sn_10-215-0-128_25"
        address_prefixes                            = ["10.215.0.128/25"]
        service_endpoints                           = null
        route_table                                 = null
        network_sec_group                           = null
  
    },
    {
        name                                        = "AzureFirewallSubnet"
        address_prefixes                            = ["10.215.0.0/25"]
        service_endpoints                           = null // ["Microsoft.Storage", "Microsoft.Sql"]
        route_table                                 = null
        network_sec_group                           = null
    }]
},{
    name                                            = "stagevnet"
    resource_group_name                             = "rg_stage"
    location                                        = null
    address_space                                   = ["10.215.1.0/24"]
    dns_servers                                     = null
    tags                                            = null
    subnets = [{
        name                                        = "extra_subnet"
        address_prefixes                            = ["10.215.1.128/25"]
        service_endpoints                           = null
        route_table                                 = null
        network_sec_group                           = null
    }]
}]
