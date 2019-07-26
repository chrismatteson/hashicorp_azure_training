# output.tf - outputs important parameters will need to finish configuring vault
# These parameters will but spit out after each terraform apply

output "download_vault" {
  value       = "sudo wget ${var.vault_url} -P /usr/local/bin/vault; sudo chmod 755 /usr/local/bin/vault"
  description = "Command to download and install Vault binary"
}

output "vault_config" {
  value       = "export VAULT_ADDR=http://${module.networking.public_ip}:8200"
  description = "Configure local vault agent to use public IP address of Vault Server"
}

output "PostgreSQL_Server_FQDN" {
  value = azurerm_mysql_server.sql.fqdn
}

output "PostgreSQL_Server_Username_Password" {
  value = "${azurerm_mysql_server.sql.administrator_login}\\${azurerm_mysql_server.sql.administrator_login_password}"
}

output "Subscription_ID" {
  value = data.azurerm_client_config.current.subscription_id
}

output "Resource_Group_Name" {
  value = azurerm_virtual_machine.main.resource_group_name
}

output "VM_Name" {
  value = azurerm_virtual_machine.main.name
}

output "JWT_Token" {
  value = "jwt=`curl http://localhost:50342/oauth2/token?resource=https://management.azure.com -H metadata:true | jq .access_token | tr -d '\"'"
}

