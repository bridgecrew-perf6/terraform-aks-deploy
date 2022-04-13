module "aks" {
  source = "./modules/aks-deploy"

  environment = var.environment

}