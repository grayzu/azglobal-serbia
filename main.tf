resource "azurerm_resource_group" "globalaz_serbia_rg" {
    name                    = "globalaz_serbia"
    location                = "westus2"
}

# Configure Vnet 
resource "azurerm_virtual_network" "globalaz_serbia_vnet" {
  name                = "demovnet"
  location            = azurerm_resource_group.globalaz_serbia_rg.location
  resource_group_name = azurerm_resource_group.globalaz_serbia_rg.name
  address_space       = ["10.0.0.0/16"]
}

# # Configure Subnet
# resource "azurerm_subnet" "globalaz_serbia_subnet" {
#     name                 = "apps"
#     resource_group_name  = azurerm_resource_group.globalaz_serbia_rg.name
#     virtual_network_name = azurerm_virtual_network.globalaz_serbia_vnet.name
#     address_prefix       = "10.0.1.0/24"
# }

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