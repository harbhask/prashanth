data "azurerm_virtual_machine" "vm" {
    count                           = var.vm_hostname == "" ? 0 : 1
    name                            = var.vm_hostname
    resource_group_name             = var.vm_resource_group_name
}

module "law" {
    source                          = "../../../../0.13/d/azurerm_log_analytics_workspace"
    name                            = var.law_name
    resource_group_name             = var.law_resource_group_name
}

resource "azurerm_virtual_machine_extension" "VM_Ext" {
    name                            = "LogAnalytics_Monitoring"
    virtual_machine_id              = var.vm_hostname == "" ? var.vm_id : data.azurerm_virtual_machine.vm[0].id
    publisher                       = "Microsoft.EnterpriseCloud.Monitoring"
    type                            = var.isLinuxVM ? "OmsAgentForLinux" : "MicrosoftMonitoringAgent"
    type_handler_version            = var.isLinuxVM ? "1.13"             : "1.0"
    auto_upgrade_minor_version      = false

    settings                        = <<SETTINGS
    {
        "workspaceId":              "${module.law.workspace_id}"
    }
SETTINGS

    protected_settings              = <<PROTECTEDSETTINGS
    {
        "workspaceKey":             "${module.law.primary_shared_key}"
    }
PROTECTEDSETTINGS
}
