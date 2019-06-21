# output.tf - outputs of service principal

output "application_id" {
  value       = "${azuread_application.vaultapp.application_id}"
  description = "Application ID for our application"
}

output "service_principal_password" {
  value       = "${azuread_service_principal_password.vaultapp.value}"
  description = "Password for service principal"
}
