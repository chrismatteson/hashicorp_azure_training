provider "azurerm" {
}

# generate random project name
resource "random_id" "project_name" {
  byte_length = 4
}

# generate client seceret
resource "random_id" "client_secret" {
  byte_length = 32
}

# Local for tag to attach to all items
locals {
  tags = merge(
    var.tags,
    {
      "ProjectName" = random_id.project_name.hex
    },
  )
}

# Azure Resources
resource "azurerm_resource_group" "main" {
  name     = "${random_id.project_name.hex}-rg"
  location = var.location
  tags     = local.tags
}

# Networking Module
module "networking" {
  source       = "./modules/networking"
  rg_name      = azurerm_resource_group.main.id
  location     = azurerm_resource_group.main.location
  project_name = random_id.project_name.hex
}

# Data Sources
data "azurerm_client_config" "current" {
}

data "template_file" "setup" {
  template = file("setupvault.tpl")

  vars = {
    vault_url = var.vault_url
  }
}

