resource "azurerm_user_assigned_identity" "mi" {
  location            = azurerm_resource_group.node.location
  name                = "aks-mi"
  resource_group_name = azurerm_resource_group.node.name
}
