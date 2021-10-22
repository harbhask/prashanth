variable "bidirectional" {
    type        = bool
}

variable "resource_group_name" {
    type        = string
}

variable "vnet_source" {
    type        = map(string)
}

variable "vnet_target" {
    type        = map(string)
}

variable "peering_outgoing" {
    type        = object({
        name                                        = string
        allow_forwarded_traffic                     = bool
        allow_gateway_transit                       = bool
        use_remote_gateways                         = bool
    })
}

variable "peering_incoming" {
    type        = object({
        name                                        = string
        allow_forwarded_traffic                     = bool
        allow_gateway_transit                       = bool
        use_remote_gateways                         = bool
    })
}

variable "tags" {
    type        = map(string)
}
