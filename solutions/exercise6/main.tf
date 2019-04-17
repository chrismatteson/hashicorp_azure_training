provider "azurerm" {}

# generate random project name
resource "random_id" "project_name" {
  byte_length = 4
}

# generate client seceret
resource "random_id" "client_secret" {
  byte_length = 32
}

# generate sql password
resource "random_id" "sql_password" {
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
  name                 = "${random_id.project_name.hex}-subnet"
  resource_group_name  = "${azurerm_resource_group.main.name}"
  virtual_network_name = "${azurerm_virtual_network.main.name}"
  address_prefix       = "10.0.1.0/24"
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
    subnet_id                     = "${azurerm_subnet.main.id}"
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

resource "azurerm_virtual_machine" "main" {
  name                          = "${random_id.project_name.hex}-vm"
  location                      = "${azurerm_resource_group.main.location}"
  resource_group_name           = "${azurerm_resource_group.main.name}"
  network_interface_ids         = ["${azurerm_network_interface.main.id}"]
  vm_size                       = "Standard_A2_v2"
  delete_os_disk_on_termination = true

  identity = {
    type = "SystemAssigned"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${random_id.project_name.hex}vm-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "${random_id.project_name.hex}vm"
    admin_username = "ubuntu"
    admin_password = "Password1234!"
    custom_data    = "${data.template_file.setup.rendered}"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_virtual_machine_extension" "virtual_machine_extension" {
  name                 = "vault"
  location             = "${var.location}"
  resource_group_name  = "${azurerm_resource_group.main.name}"
  virtual_machine_name = "${azurerm_virtual_machine.main.name}"
  publisher            = "Microsoft.ManagedIdentity"
  type                 = "ManagedIdentityExtensionForLinux"
  type_handler_version = "1.0"

  settings = <<SETTINGS
    {
        "port": 50342
    }
SETTINGS
}

resource "azurerm_sql_server" "sql" {
  name                         = "${random_id.project_name.hex}-sql"
  resource_group_name          = "${azurerm_resource_group.main.name}"
  location                     = "${azurerm_resource_group.main.location}"
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "${random_id.sql_password.id}"
}
