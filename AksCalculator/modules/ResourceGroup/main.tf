resource "azurerm_resource_group" "tf_resource_group" {
  name     = var.rg_name
  location = var.location
}