resource "azurerm_resource_group" "rg" {
  location = "uksouth"
  name     = "aks-${var.environment}"
}