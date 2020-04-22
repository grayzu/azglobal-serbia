resource "azurerm_resource_group" "globalaz_serbia_rg" {
    name                    = "globalaz_serbia"
    location                = "westus2"
}

# Give existing identity read permission to resource group
data "azurerm_user_assigned_identity" "monitor" {
    name                = "monitor-api"
    resource_group_name = "globalaz_serbia_mon"
}

resource "azurerm_role_assignment" "example" {
    scope                = azurerm_resource_group.globalaz_serbia_rg.id
    role_definition_name = "Reader"
    principal_id         = data.azurerm_user_assigned_identity.monitor.principal_id
}

# Configure Vnet 
resource "azurerm_virtual_network" "globalaz_serbia_vnet" {
    name                = "demovnet"
    location            = azurerm_resource_group.globalaz_serbia_rg.location
    resource_group_name = azurerm_resource_group.globalaz_serbia_rg.name
    address_space       = ["10.0.0.0/16"]
}

# Configure Subnet
resource "azurerm_subnet" "globalaz_serbia_subnet" {
    count                = var.num_subnets
    name                 = "subnet-${count.index + 1}"
    resource_group_name  = azurerm_resource_group.globalaz_serbia_rg.name
    virtual_network_name = azurerm_virtual_network.globalaz_serbia_vnet.name
    address_prefix       = cidrsubnet(azurerm_virtual_network.globalaz_serbia_vnet.address_space.0,8,count.index + 1)
}

# create and assign security groups
resource "azurerm_network_security_group" "globalaz_serbia_sgs" {
    name                = "default-rules"
    location            = azurerm_resource_group.globalaz_serbia_rg.location
    resource_group_name = azurerm_resource_group.globalaz_serbia_rg.name

    dynamic "security_rule" {
        for_each = var.security_group_rules

        content {
            name                       = lower(security_rule.value.name)
            description                = "Allow inbound traffic for ${security_rule.value.protocol}"
            priority                   = security_rule.value.priority
            direction                  = security_rule.value.direction
            access                     = security_rule.value.access
            protocol                   = title(security_rule.value.protocol)
            source_port_range          = "*"
            destination_port_range     = security_rule.value.destinationPortRange
            source_address_prefix      = "*"
            destination_address_prefix = "VirtualNetwork"
        }
    }
}

resource "azurerm_subnet_network_security_group_association" "preday" {
    subnet_id                 = azurerm_subnet.globalaz_serbia_subnet.0.id
    network_security_group_id = azurerm_network_security_group.globalaz_serbia_sgs.id
}
