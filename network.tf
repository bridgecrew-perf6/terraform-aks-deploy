resource "azurerm_resource_group" "network" {
  location = "uksouth"
  name     = "aks-  ${var.environment}-network-rg"
}

resource "azurerm_virtual_network" "aks" {
  address_space       = ["172.16.0.0/16", ]
  location            = azurerm_resource_group.network.location
  name                = "aks-vnet"
  resource_group_name = azurerm_resource_group.network.name
}

resource "azurerm_subnet" "aks" {
  name                 = "aks"
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.aks.name
  address_prefixes     = ["172.16.0.0/24"]
}