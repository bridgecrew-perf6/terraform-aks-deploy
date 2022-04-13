module "aks" {
  source = "./modules/aks-deploy"

  environment = var.environment
}

/*
module "aks-bootstrap" {
  source = "./modules/aks-bootstrap"
}
*/

locals {
  kube-config = {
    kube_host                   = module.aks.host.value
    kube_client_certificate     = module.aks.client_certificate.value
    kube_client_key             = module.aks.client_key.value
    kube_cluster_ca_certificate = module.aks.cluster_ca_certificate.value
  }
}