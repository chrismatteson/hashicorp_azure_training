provider "azurerm" {}

# generate random project name
resource "random_id" "project_name" {
  byte_length = 4
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
  address_prefix       = "10.0.${count.index + 1}.0/24"
}

resource "azurerm_public_ip" "main" {
  name                = "${random_id.project_name.hex}-pubip"
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"
  allocation_method   = "Static"
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

data "template_file" "setup" {
  template = "${file("setupvault.tpl")}"

  vars = {
    vault_url = var.vault_url
  }
}
