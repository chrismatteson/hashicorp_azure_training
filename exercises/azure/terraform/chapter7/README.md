### Chapter 7 - Exercise 1 - Provide API Credentials
* Navigate to Variables tab of workspace and create the following variables and populate with data from your current state file
* Run a terraform plan and apply and see what is new.
* View run status in UI
* Trigger a Plan from the UI

`ARM_CLIENT_ID: azuread_application.vaultapp.application_id`  
`ARM_TENANT_ID: azurerm_client_config.current.tenant_id`  
`ARM_SUBSCRIPTION_ID: azurerm_client_config.current.subscription_id`  
`ARM_CLIENT_SECRET: azuread_service_principal_password.vaultapp.value`  

`HINT 1: Click "Sensitive" after entering the value for ARM_CLIENT_SECRET to prevent accidential exposure`
