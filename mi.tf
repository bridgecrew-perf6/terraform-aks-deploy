resource "azurerm_user_assigned_identity" "mi" {
  location            = azurerm_resource_group.cluster.location
  name                = "aks-mi"
  resource_group_name = azurerm_resource_group.cluster.name
}
