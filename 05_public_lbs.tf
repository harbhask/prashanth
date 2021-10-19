variable "public_lbs" {
    type = list(object({
        name                                = string
        resource_group_name                 = string
        location                            = string
        frontend_name                       = string
        public_ip                           = map(string)
        tags                                = map(string)
    }))
}

module "public_lbs" {
    source                                  =  "../../modules/0.13/r/azurerm_lb_public"
    for_each                                = { for lb in toset(var.public_lbs) : lb.name => lb }
        name                                = each.key
        resource_group_name                 = each.value.resource_group_name
        location                            = each.value.location
        frontend_name                       = each.value.frontend_name
        public_ip                           = each.value.public_ip
        tags                                = merge(var.overall_tags, each.value.tags)
}
