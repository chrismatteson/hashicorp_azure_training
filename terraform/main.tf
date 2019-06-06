# Create passwords and user accounts for every student

resource "random_pet" "password" {
  length = 1
}

resource "random_string" "password" {
  count       = "${length(var.users)}"
  length      = 6
  min_upper   = 1
  lower       = false
  min_numeric = 1
  min_special = 1
}

data "azuread_domains" "default" {
  only_default = true
}

resource "azuread_user" "user" {
  count               = "${length(var.users)}"
  user_principal_name = "${element(var.users,count.index)}@${data.azuread_domains.default.domains.0.domain_name}"
  display_name        = "${element(var.users,count.index)}"
  mail_nickname       = "${element(var.users,count.index)}"
  password            = "${random_pet.password.*.id[count.index]}${random_string.password.*.result[count.index]}"
}

resource "azurerm_role_assignment" "user" {
  count                = "${length(var.users)}"
  scope                = "${data.azurerm_subscription.primary.id}"
  role_definition_name = "Contributor"
  principal_id         = "${azuread_user.user.*.id[count.index]}"
}

# Create shared Service Principal
data "azurerm_client_config" "current" {}

data "azurerm_subscription" "primary" {}

resource "random_id" "prefix" {
  byte_length = 2
}

resource "random_id" "client_secret" {
  byte_length = 32
}

resource "azuread_application" "app" {
  name = "${random_id.prefix.hex}-app"
}

resource "azuread_service_principal" "app" {
  application_id = "${azuread_application.app.application_id}"
}

resource "azuread_service_principal_password" "app" {
  service_principal_id = "${azuread_service_principal.app.id}"
  value                = "${random_id.client_secret.id}"
  end_date             = "2020-01-01T01:02:03Z"
  depends_on           = ["azurerm_role_assignment.role_assignment"]
}

resource "azurerm_role_assignment" "role_assignment" {
  scope                = "${data.azurerm_subscription.primary.id}"
  role_definition_name = "Contributor"
  principal_id         = "${azuread_service_principal.app.id}"
}
