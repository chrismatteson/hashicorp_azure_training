provider "azurerm" {
}

# generate random project name
resource "random_id" "project_name" {
  byte_length = 4
}

# Azure Resources
resource "azurerm_resource_group" "main" {
  name     = "${random_id.project_name.hex}-rg"
  location = "eastus"
}
