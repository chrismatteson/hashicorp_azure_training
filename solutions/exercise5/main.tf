provider "azurerm" {}

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
  tags = "${merge(var.tags, map("ProjectName", random_id.project_name.hex))}"
}

# Azure Resources
resource "azurerm_resource_group" "main" {
  name     = "${random_id.project_name.hex}-rg"
  location = "${var.location}"
  tags     = "${local.tags}"
}

# Azure Networking Resources
resource "azurerm_virtual_network" "main" {
  name                = "${random_id.project_name.hex}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"
}

resource "azurerm_subnet" "main" {
  count                = 3
  name                 = "${random_id.project_name.hex}-subnet-${count.index}"
  resource_group_name  = "${azurerm_resource_group.main.name}"
  virtual_network_name = "${azurerm_virtual_network.main.name}"
  address_prefix       = "10.0.${count.index+1}.0/24"
}

resource "azurerm_public_ip" "main" {
  name                         = "${random_id.project_name.hex}-pubip"
  location                     = "${azurerm_resource_group.main.location}"
  resource_group_name          = "${azurerm_resource_group.main.name}"
  allocation_method            = "Static"
}

resource "azurerm_network_interface" "main" {
  name                = "${random_id.project_name.hex}-nic"
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"

  ip_configuration {
    name                          = "config1"
    subnet_id                     = "${azurerm_subnet.main.0.id}"
    public_ip_address_id          = "${azurerm_public_ip.main.id}"
    private_ip_address_allocation = "dynamic"
  }
}

# Data Sources
data "azurerm_client_config" "current" {}

data "azurerm_subscription" "subscription" {}

data "azurerm_role_definition" "role_definition" {
  name = "Contributor"
}

data "template_file" "setup" {
  template = "${file("setupvault.tpl")}"

  vars {
    vault_url             = "${var.vault_url}"
  }
}

# AzureAD resources
resource "azuread_application" "vaultapp" {
  name = "${random_id.project_name.hex}-vaultapp"
}

resource "azuread_service_principal" "vaultapp" {
  application_id = "${azuread_application.vaultapp.application_id}"
}

resource "azuread_service_principal_password" "vaultapp" {
  service_principal_id = "${azuread_service_principal.vaultapp.id}"
  value                = "${random_id.client_secret.id}"
  end_date             = "2020-01-01T01:02:03Z"
  depends_on           = ["azurerm_role_assignment.role_assignment"]
}

resource "azurerm_role_assignment" "role_assignment" {
  scope              = "${data.azurerm_subscription.subscription.id}"
  role_definition_id = "${data.azurerm_subscription.subscription.id}${data.azurerm_role_definition.role_definition.id}"
  principal_id       = "${azuread_service_principal.vaultapp.id}"
}
