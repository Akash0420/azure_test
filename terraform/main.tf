# Configure Azure Provider
provider "azurerm" {
  features {}
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
  account_tier        = "Standard_LRS"
  account_replication_type = "LRS"

  # Access for Service Principal
  access_tier = "Hot"

  timeouts {
    create = "10m"
  }
}