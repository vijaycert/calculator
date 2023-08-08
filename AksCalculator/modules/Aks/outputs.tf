output "aks_id" {
    value = azurerm_kubernetes_cluster.tf_aks.id
}

output "aks_name" {
    value = azurerm_kubernetes_cluster.tf_aks.name
}
