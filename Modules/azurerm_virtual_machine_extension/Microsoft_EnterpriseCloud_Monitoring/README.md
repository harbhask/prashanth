# Usage of the module
Author:
* Ajay Kumar <ajay.kumar@icfnext.com>

Version: 0.13.2

Date:    21.10.2021

&nbsp;

## Templates

//Todo: Review

### terraform .tfvars
```hcl
Part of the VM settings
```

### variable .tf
```hcl
Part of the VM settings
```

### main .tf
```hcl
module "vm_Exts_EnterpriseCloud_Monitoring" {
    source                                          = "../../../0.13/r/azurerm_virtual_machine_extension_EnterpriseCloud_Monitoring.MicrosoftMonitoringAgent"
    vm_hostname                                     = azurerm_windows_virtual_machine.vm.name
    vm_resource_group_name                          = azurerm_windows_virtual_machine.vm.resource_group_name

    log_analytics_workspace                         = var.log_analytics_workspace.name
    log_analytics_workspace_resource_group_name     = var.log_analytics_workspace.resource_group_name
}
```
