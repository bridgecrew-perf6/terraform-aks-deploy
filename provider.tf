terraform {
  required_version = ">=0.12.31"

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      # version = "2.24.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.10.0"
    }
  }

  backend "azurerm" {
    storage_account_name = "hybridaccessterraform"
    container_name       = "tfstate"
    key                  = "aks-deploy-sandbox"
    subscription_id      = "02b44a0d-f98e-407e-b0c1-7d394305857e"
    tenant_id            = "c555cdfa-e1fa-4957-b451-1ff2ce91d0a7"
    resource_group_name  = "terraform-bootstrap"
  }
}

provider "azurerm" {
  features {}
}

provider "kubernetes" {
  host                   = local.kube-config.kube_host
  client_certificate     = local.kube-config.kube_client_certificate
  client_key             = local.kube-config.kube_client_key
  cluster_ca_certificate = local.kube-config.kube_cluster_ca_certificate
}