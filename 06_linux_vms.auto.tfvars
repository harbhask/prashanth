linux_vms = [{
    hostname                                        = 
    tags                                            = null
    resource_group_name                             = 
    location                                        = null
    vnet = {
        name                                        = 
        resource_group_name                         = 
        subnet_name                                 = 
    }
    keyvault = {
        name                                        = 
        resource_group_name                         = 
    }
    vm_data = {
        admin_password_secret                       = "demoUser@123"
        admin_username_secret                       = "username"
        allow_extension_operations                  = true
        availability_zone                           = null
        boot_diagnostics                            = true
        boot_diagnostics_sa_type                    = "Standard_LRS"
        os_disk_caching                             = "None"
        os_disk_storage_account_type                = "Premium_LRS"
        provision_vm_agent                          = true
        size                                        = "Standard_B2s"
        vm_os_offer                                 = "RHEL"
        vm_os_publisher                             = "RedHat"
        vm_os_sku                                   = "7.4"
        vm_os_version                               = "latest"
        public_key                                  = ""
        disable_password_authentication             = false
        storage_data_disk = [{
            caching                                 = "None"
            managed_disk_type                       = "StandardSSD_LRS"
            disk_size_gb                            = 32
            write_accelerator_enabled               = false
        }]
    }

    nic = {
        app_sec_group                               = ""
        enable_accelerated_networking               = false
        private_ip_address                          = ""
    }
}]
