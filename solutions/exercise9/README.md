## 9.0 Solutions
`vault auth enable azure`
`vault write auth/azure/config \
  tenant_id=${data.azurerm_client_config.current.tenant_id} \
  resource=https://management.azure.com \
  client_id=${azuread_application.vaultapp.application_id} \
  client_secret=${azuread_service_principal_password.vaultapp.value}`

## 9.1 Solutions
`vault secrets enable -version2 kv`
`vault kv enable-versioning secret/`
`vault kv put secret/my-secret my-value=s3cr3t`
`vault kv get secret/my-secret`
`vault kv put secret/my-secret my-value=new-s3cr3t`
`vault kv get secret/my-secret`
`vault kv get -verison=1 secret/my-secret`
