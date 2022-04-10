resource "azurerm_resource_group" "rg" {
  location = "uksouth"
  name     = "aks-${var.environment}"
}

resource "azurerm_user_assigned_identity" "mi" {
  location            = azurerm_resource_group.rg.location
  name                = "aks-mi"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-${var.environment}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "hax-aks"

  default_node_pool {
    name       = "linux"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.mi.id
    ]
  }

  tags = {
    Environment = "sandbox"
  }
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true

}