# Data source reference to key vault instance
data "azurerm_key_vault" "globalaz_serbia_kv" {
    name                = var.key_vault
    resource_group_name = "globalaz_serbia_mon"
}

# Data source reference to the secret
data "azurerm_key_vault_secret" "globalaz_serbia_pwd" {
    name         = var.secret_id
    key_vault_id = data.azurerm_key_vault.globalaz_serbia_kv.id
}

# Configure Network Interface
resource "azurerm_network_interface" "globalaz_serbia_nic" {
    name                    = "globalazserbianic"
    location                = azurerm_resource_group.globalaz_serbia_rg.location
    resource_group_name     = azurerm_resource_group.globalaz_serbia_rg.name

    ip_configuration {
        name                          = "globalazipconfig"
        subnet_id                     = azurerm_subnet.globalaz_serbia_subnet.0.id
        private_ip_address_allocation = "Dynamic"
    }
}

# Configure Virtual Machine
resource "azurerm_linux_virtual_machine" "globalaz_serbia_vm" {
    name                            = "globalaz-serbia"
    location                        = azurerm_resource_group.globalaz_serbia_rg.location
    resource_group_name             = azurerm_resource_group.globalaz_serbia_rg.name
    size                            = "Standard_B1s"
    admin_username                  = "adminuser"
    admin_password                  = data.azurerm_key_vault_secret.globalaz_serbia_pwd.value
    disable_password_authentication = false

    network_interface_ids   = [
        azurerm_network_interface.globalaz_serbia_nic.id
    ]

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "16.04-LTS"
        version   = "latest"
    }

    os_disk {
        name                    = "myosdisk1"
        caching                 = "ReadWrite"
        storage_account_type    = "Standard_LRS"
    }
}