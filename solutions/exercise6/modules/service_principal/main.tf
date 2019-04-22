# generate client seceret
resource "random_id" "client_secret" {
  byte_length = 32
}

# AzureAD resources
resource "azuread_application" "vaultapp" {
  name = "${var.project_name}-vaultapp"
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
  scope              = "${var.subscription_id}"
  role_definition_id = "${var.subscription_id}${var.role_definition_id}"
  principal_id       = "${azuread_service_principal.vaultapp.id}"
}
