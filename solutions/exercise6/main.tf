provider "azurerm" {}

# generate random project name
resource "random_id" "project_name" {
  byte_length = 4
}

resource "random_id" "client_secret" {
  byte_length = 32
}

# Azure Resources
data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "main" {
  name     = "${random_id.project_name.hex}-rg"
  location = "${var.location}"

  tags {
    DoNotDelete = "true"
  }
}

resource "azurerm_azuread_application" "vaultapp" {
  name = "${random_id.project_name.hex}-vaultapp"
}

resource "azurerm_azuread_service_principal" "vaultapp" {
  application_id = "${azurerm_azuread_application.vaultapp.application_id}"
}

resource "azurerm_azuread_service_principal_password" "vaultapp" {
  service_principal_id = "${azurerm_azuread_service_principal.vaultapp.id}"
  value                = "${random_id.client_secret.id}"
  end_date             = "2020-01-01T01:02:03Z"
  depends_on           = ["azurerm_role_assignment.role_assignment"]
}

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

# VM Resources
resource "azurerm_public_ip" "main" {
  name                         = "${random_id.project_name.hex}-pubip"
  location                     = "${azurerm_resource_group.main.location}"
  resource_group_name          = "${azurerm_resource_group.main.name}"
  public_ip_address_allocation = "static"
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

data "template_file" "setup" {
  template = "${file("setupvault.tpl")}"

  vars {
    aws_iam_access_key    = "${aws_iam_access_key.vault.id}"
    aws_iam_secret_key    = "${aws_iam_access_key.vault.secret}"
    aws_region            = "${var.aws_region}"
    aws_s3_bucket         = "${aws_s3_bucket.appdata.bucket}"
    azure_tenant_id       = "${data.azurerm_client_config.current.tenant_id}"
    azure_application_id  = "${azurerm_azuread_application.vaultapp.application_id}"
    azure_sp_password     = "${azurerm_azuread_service_principal_password.vaultapp.value}"
    azure_subscription_id = "${data.azurerm_client_config.current.subscription_id}"
    azure_resource_group  = "${azurerm_resource_group.main.name}"
    vault_url             = "${var.vault_url}"
    azure_key_vault_key   = "generated-certificate"
    azure_key_vault       = "${format("%s%s", "kv", random_id.project_name.hex)}"
    vault_token           = "${random_id.vault_token.id}"
  }
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

resource "null_resource" "main" {

  triggers {
    vault_vm = "${azurerm_virtual_machine.main.id}"
  }

  provisioner "local-exec" {
    command = "until $(curl --silent --fail http://${azurerm_public_ip.main.ip_address}:8200/v1/sys/init | jq .initialized ) -eq 'true'; do printf '.'; sleep 2; done"
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

data "azurerm_subscription" "subscription" {}

data "azurerm_builtin_role_definition" "builtin_role_definition" {
  name = "Contributor"
}

# Grant the VM identity contributor rights to the current subscription
resource "azurerm_role_assignment" "role_assignment" {
  scope              = "${data.azurerm_subscription.subscription.id}"
  role_definition_id = "${data.azurerm_subscription.subscription.id}${data.azurerm_builtin_role_definition.builtin_role_definition.id}"
  principal_id       = "${azurerm_azuread_service_principal.vaultapp.id}"

  lifecycle {
    ignore_changes = ["name"]
  }
}

resource "azurerm_key_vault" "autounseal" {
  name                = "${format("%s%s", "kv", random_id.project_name.hex)}"
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"
  tenant_id           = "${data.azurerm_client_config.current.tenant_id}"

  sku {
    name = "premium"
  }

  access_policy {
    tenant_id = "${data.azurerm_client_config.current.tenant_id}"
    object_id = "${azurerm_azuread_service_principal.vaultapp.id}"

    key_permissions = [
      "create",
      "get",
      "delete",
      "decrypt",
      "encrypt",
      "unwrapKey",
      "wrapKey",
      "verify",
      "sign",
    ]

    secret_permissions = [
      "get",
      "set",
    ]
  }

  access_policy {
    tenant_id = "${data.azurerm_client_config.current.tenant_id}"
    object_id = "${azurerm_virtual_machine.main.identity.0.principal_id}"

    key_permissions = [
      "create",
      "get",
      "delete",
      "decrypt",
      "encrypt",
      "unwrapKey",
      "wrapKey",
      "verify",
      "sign",
    ]

    secret_permissions = [
      "get",
      "set",
    ]
  }

  tags {
    project = "multicloud_vault_demo"
  }
}

provider azurerm {
  alias           = "service_principal"
  tenant_id       = "${data.azurerm_client_config.current.tenant_id}"
  subscription_id = "${data.azurerm_client_config.current.subscription_id}"
  client_id       = "${azurerm_azuread_service_principal.vaultapp.application_id}"
  client_secret   = "${azurerm_azuread_service_principal_password.vaultapp.value}"
}

resource "azurerm_key_vault_key" "seal" {
  provider  = "azurerm.service_principal"
  name      = "generated-certificate"
  vault_uri = "${azurerm_key_vault.autounseal.vault_uri}"
  key_type  = "RSA"
  key_size  = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}
