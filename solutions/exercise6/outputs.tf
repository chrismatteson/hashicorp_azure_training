# output.tf - outputs important parameters will need to finish configuring vault
# These parameters will but spit out after each terraform apply

output "download vault" {
  value       = "sudo wget ${var.vault_url} -P /usr/local/bin/vault; sudo chmod 755 /usr/local/bin/vault"
  description = "Command to download and install Vault binary"
}

output "vault config" {
  value       = "export VAULT_ADDR=http://${azurerm_public_ip.main.ip_address}:8200"
  description = "Configure local vault agent to use public IP address of Vault Server"
}

output "vault-msi-auth" {
  value = "vault write auth/azure/login role=\"dev-role\" subscription_id=\"${data.azurerm_client_config.current.subscription_id}\" resource_group_name=\"${azurerm_virtual_machine.main.resource_group_name}\" vm_name=\"${azurerm_virtual_machine.main.name}\" jwt=`curl http://localhost:50342/oauth2/token?resource=https://management.azure.com -H metadata:true | jq .access_token | tr -d '\"'"
}
