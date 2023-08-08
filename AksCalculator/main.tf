module "ResourceGroup" {
  source = "./modules/ResourceGroup"

  rg_name  = var.rg_name
  location = var.location
}

module "AzKubeCluster" {
  source = "./modules/Aks"

  aks_name = var.aks_name
  location = var.location

  resource_group_name = module.ResourceGroup.rg_name_out
  aks_node_pool_name  = var.aks_node_pool_name
  aks_cr_name         = var.aks_cr_name
  aks_vm_size         = var.aks_vm_size
  aks_acr_role_defn   = var.aks_acr_role_defn
}