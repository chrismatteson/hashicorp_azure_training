## Chapter 4 Solutions

* Enable userpass auth
`vault auth enable userpass`
`vault write auth/userpass/users/mitchellh password=foo`

* Enable azure auth
`vault auth enable azure`
`vault write auth/azure/config \
  tenant_id=${data.azurerm_client_config.current.tenant_id} \
  resource=https://management.azure.com \
  client_id=${azuread_application.vaultapp.application_id} \
  client_secret=${azuread_service_principal_password.vaultapp.value}`

