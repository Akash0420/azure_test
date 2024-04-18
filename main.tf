# Configure Azure Provider
provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name = "cloud-shell-storage-centralindia"
    storage_account_name = "csg10032003730c9146"
  }
}
# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "github-actions-rg"
  location = "centralindia"
}

# Service Principal for Access
data "azurerm_client_secret" "sp" {
  name = "tmp"
}

# Storage Account
resource "azurerm_storage_account" "storage" {
  name                = "githubactionstorage"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  account_tier        = "Standard"
  account_replication_type = "LRS"

  # Access for Service Principal
  access_tier = "Hot"

  timeouts {
    create = "10m"
  }
}