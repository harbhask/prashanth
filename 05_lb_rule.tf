variable "lb_rules" {
    type = list(object({
        name                                = string
        lb_resource_group_name              = string
        lb_name                             = string
        protocol                            = string
        frontend_port                       = string
        frontend_name                       = string
        backend_port                        = string
    }))
}

module "lb_rule" {
    depends_on                              = [module.public_lbs,module.private_lbs]
    source                                  = "../../modules/0.13/r/azurerm_lb_rule"
    for_each                                = { for lb_rule in toset(var.lb_rules) : lb_rule.name => lb_rule }
        name                                = each.key
        lb_name                             = each.value.lb_name
        lb_resource_group_name              = each.value.lb_resource_group_name
        frontend_name                       = each.value.frontend_name
        protocol                            = each.value.protocol
        frontend_port                       = each.value.frontend_port
        backend_port                        = each.value.backend_port
}
