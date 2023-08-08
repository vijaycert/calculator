resource "azurerm_kubernetes_cluster" "tf_aks" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "dnstfaks"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = var.aks_vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
  }
  
}


resource "azurerm_kubernetes_cluster_node_pool" "tf_aks_node_pool" {
  name                  = var.aks_node_pool_name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.tf_aks.id
  vm_size               = var.aks_vm_size
  node_count            = 2

  depends_on = [ azurerm_kubernetes_cluster.tf_aks ]
  tags = {
    Environment = "Development"
  }
}

resource "azurerm_container_registry" "tf_aks_cr" {
  name                = var.aks_cr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"

}

resource "azurerm_role_assignment" "tf_aks_role_assignment" {
  principal_id                     = azurerm_kubernetes_cluster.tf_aks.identity[0].principal_id
  role_definition_name             = var.aks_acr_role_defn
  scope                            = azurerm_container_registry.tf_aks_cr.id
  skip_service_principal_aad_check = true

  depends_on = [ azurerm_kubernetes_cluster.tf_aks, azurerm_container_registry.tf_aks_cr ]
}