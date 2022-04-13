resource "azurerm_resource_group" "cluster" {
  location = "uksouth"
  name     = "aks-${var.environment}"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-${var.environment}"
  location            = azurerm_resource_group.cluster.location
  resource_group_name = azurerm_resource_group.cluster.name
  dns_prefix          = "hax-aks"
  kubernetes_version  = "1.21.7"

  node_resource_group = "aks-nodepool-${var.environment}"

  sku_tier = "Free"



  network_profile {
    network_plugin = "azure"
  }

  azure_active_directory_role_based_access_control {
    azure_rbac_enabled     = true
    managed                = true
    admin_group_object_ids = ["be0df5c5-5c0d-449b-97ce-0c0b6fcc61f6"]
  }


  default_node_pool {
    name                  = "linux"
    type                  = "VirtualMachineScaleSets"
    node_count            = 1
    vm_size               = "Standard_D2_v2"
    os_disk_type          = "Managed"
    os_disk_size_gb       = "128"
    vnet_subnet_id        = azurerm_subnet.aks.id
    enable_auto_scaling   = true
    min_count             = 1
    max_count             = 2
    max_pods              = 100
    zones                 = []
    orchestrator_version  = "1.21.7"
    enable_node_public_ip = false

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