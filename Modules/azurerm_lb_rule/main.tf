data "azurerm_resource_group" "rg" {
    name                                = var.lb_resource_group_name
}

data "azurerm_lb" "lb" {
    name                                = var.lb_name
    resource_group_name                 = data.azurerm_resource_group.rg.name
}



resource "azurerm_lb_rule" "lb" {
    resource_group_name                 = data.azurerm_resource_group.rg.name
    loadbalancer_id                     = data.azurerm_lb.lb.id
    name                                = var.name
    protocol                            = var.protocol
    frontend_port                       = var.frontend_port
    backend_port                        = var.backend_port
    frontend_ip_configuration_name      = var.frontend_name
}
