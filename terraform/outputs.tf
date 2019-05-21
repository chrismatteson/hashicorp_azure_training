output "users" {
  value = "${zipmap(azuread_user.user.*.user_principal_name, azuread_user.user.*.password)}"
}
