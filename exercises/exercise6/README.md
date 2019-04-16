## 6.0 HashiCorp Terraform - Virtual Machine
Create an Azure Virtual Machine

### 6.0 Tasks
Create an Azure Virtual Machine to use the resource group, and, network interface created in prior exercises.

https://www.terraform.io/docs/providers/azurerm/r/virtual_machine.html

`HINT 1: Use vm_size Standard_A2_v2.`

## 6.1 HashiCorp Terraform - Virtual Machine Extension
Create VM extension

### 6.1 Tasks
Add the MSI virtual machine extension to the VM created in the prior exercise.

https://www.terraform.io/docs/providers/azurerm/r/virtual_machine_extension.html
https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/overview

`HINT 1: Use the publisher "Microsoft.ManagedIdentity", the type "ManagedIdentityExtensionForLinux" and type_handler_version "1.0"`

## 6.2 HashiCorp Terraform - Add useful output
Create an output for Vault server

### 6.2 Tasks
Add outputs to ease using the Terraform code.

https://www.terraform.io/docs/configuration/outputs.html

`export VAULT_ADDR=http://${azurerm_public_ip.main.ip_address}:8200`
`vault write auth/azure/login role=\"dev-role\" subscription_id=\"${data.azurerm_client_config.current.subscription_id}\" resource_group_name=\"${azurerm_virtual_machine.main.resource_group_name}\" vm_name=\"${azurerm_virtual_machine.main.name}\" jwt=`curl http://localhost:50342/oauth2/token?resource=https://management.azure.com -H metadata:true | jq .access_token | tr -d '\"'`
