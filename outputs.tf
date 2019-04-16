# output.tf - outputs important parameters will need to finish configuring vault
# These parameters will but spit out after each terraform apply

output "public-ip" {
  value       = "${azurerm_public_ip.main.ip_address}"
  description = "Public IP Address"
}

output "vault-msi-auth" {
  value = "vault write auth/azure/login role=\"dev-role\" subscription_id=\"${data.azurerm_client_config.current.subscription_id}\" resource_group_name=\"${azurerm_virtual_machine.main.resource_group_name}\" vm_name=\"${azurerm_virtual_machine.main.name}\" jwt=`curl http://localhost:50342/oauth2/token?resource=https://management.azure.com -H metadata:true | jq .access_token | tr -d '\"'"
}

output "vault-load-creds" {
  value = "S3CREDS=`vault read -format=json aws/creds/s3-role`; export AWS_ACCESS_KEY_ID=`echo $S3CREDS | jq .data.access_key | tr -d '\"'`; export AWS_SECRET_ACCESS_KEY=`echo $S3CREDS | jq .data.secret_key | tr -d '\"'`"
}

output "vault-access-s3" {
  value = "aws s3 --region us-east-2 ls s3://${aws_s3_bucket.appdata.bucket}"
}

output "vault_token" {
  value = "${random_id.vault_token.id}"
}
