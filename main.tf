module "aks" {
  source = "./modules/aks-deploy"

  environment = var.environment
}


module "aks-bootstrap" {
  source = "./modules/aks-bootstrap"
}

locals {
  kube-config = {
    kube_host                   = module.aks.host
    kube_client_certificate     = base64decode(module.aks.client_certificate)
    kube_client_key             = base64decode(module.aks.client_key)
    kube_cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)
  }
}