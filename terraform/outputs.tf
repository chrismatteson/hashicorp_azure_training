output "users" {
  value = "${zipmap(azuread_user.user.*.user_principal_name, azuread_user.user.*.password)}"
}

output "ARM_SUBSCRIPTION_ID" {
  value = "${data.azurerm_client_config.current.subscription_id}"
}

output "ARM_TENANT_ID" {
  value = "${data.azurerm_client_config.current.tenant_id}"
}

output "ARM_CLIENT_ID" {
  value = "${azuread_application.app.application_id}"
}

output "ARM_CLIENT_SECRET" {
  value = "${azuread_service_principal_password.app.value}"
}
