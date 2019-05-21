resource "random_id" "user" {
  count       = "${length(var.users)}"
  byte_length = "12"
}

resource "azuread_user" "user" {
  count               = "${length(var.users)}"
  user_principal_name = "${element(var.users,count.index)}@hashicorptraining.onmicrosoft.com"
  display_name        = "${element(var.users,count.index)}"
  mail_nickname       = "${element(var.users,count.index)}"
  password            = "${random_id.user.*.id[count.index]}"
}
