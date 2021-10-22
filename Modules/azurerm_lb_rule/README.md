# Usage of the module
Author:
* Ajay Kumar <ajay.kumar@icfnext.com>

Version: 0.13.2

Date:    21.10.2021

&nbsp;

## Templates

### terraform .tfvars
```hcl
lb_rules = [{
    name                      = "lbrule_public"
    lb_resource_group_name    = "RG_01"
    lb_name                   = "LB_01"
    protocol                  = "tcp"
    frontend_name             = "LB_01_frt"
    frontend_port             = 1234
    backend_port              = 1234
}]
```

### variable .tf
```hcl
variable "lb_rules" {
    type = list(object({
        name                      = string
        lb_name                   = string
        lb_resource_group_name    = string
        protocol                  = string
        frontend_port             = string
        frontend_name             = string
        backend_port              = string
    }))
}
```

### main .tf
```hcl
module "lb_rule" {
    depends_on                      = [module.public_lbs]
    source                          = "../modules/azurerm_lb_rule"
    for_each                        = { for lb_rule in toset(var.lb_rules) : lb_rule.name => lb_rule }
        name                        = each.key
        lb_name                     = each.value.lb_name
        lb_resource_group_name      = each.value.lb_resource_group_name
        frontend_name               = each.value.frontend_name
        protocol                    = each.value.protocol
        frontend_port               = each.value.frontend_port
        backend_port                = each.value.backend_port
}
```
