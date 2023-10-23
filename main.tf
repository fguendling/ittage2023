terraform {
  required_version = "1.5.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.75.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "example-resource-group"
  location = "West Europe"
}

# Create a Storage account
resource "azurerm_storage_account" "example" {
  name                     = "ittagestorageaccount2"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "my-terraform-env"
  }
}

# Create a Storage container
resource "azurerm_storage_container" "example" {
  name                  = "ittagestoragecontainer"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "blob"
}

# Create a Blob
resource "azurerm_storage_blob" "example" {
  name                   = "hello.txt"
  storage_account_name   = azurerm_storage_account.example.name
  storage_container_name = azurerm_storage_container.example.name
  type                   = "Block"
  source                 = "hello.txt"
}
