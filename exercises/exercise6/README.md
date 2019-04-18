## 6.0 HashiCorp Terraform - Virtual Machine
Create an Azure Virtual Machine

### 6.0 Tasks
* Create an Azure Virtual Machine to use the resource group, network interface, and template_file as custom_data, which were created in prior exercises.

https://www.terraform.io/docs/providers/azurerm/r/virtual_machine.html

`HINT 1: Use vm_size Standard_A2_v2.`

## 6.1 HashiCorp Terraform - Virtual Machine Extension
Create VM extension

### 6.1 Tasks
* Add the MSI virtual machine extension to the VM created in the prior exercise.

https://www.terraform.io/docs/providers/azurerm/r/virtual_machine_extension.html
https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/overview

`HINT 1: Use the publisher "Microsoft.ManagedIdentity", the type "ManagedIdentityExtensionForLinux" and type_handler_version "1.0"`

## 6.2 HashiCorp Terraform - MySQL Server
Manage non-virtual machine resources

### 6.2 Tasks
* Create a managed MySQL Server Instance and Database. Create a new random_id to provide the password.
* Create a firewall rule to allow access from the public IP of our virtual machine

https://www.terraform.io/docs/providers/azurerm/r/mysql_server.html
https://www.terraform.io/docs/providers/azurerm/r/mysql_database.html
https://www.terraform.io/docs/providers/azurerm/r/mysql_firewall_rule.html

## 6.3 HashiCorp Terraform - Add useful output
Create serveral new outputs

### 6.3 Tasks
* Add outputs for to ease using the Terraform code.

https://www.terraform.io/docs/configuration/outputs.html

* Configure Vault: `export VAULT_ADDR=http://${azurerm_public_ip.main.ip_address}:8200`
* SQL Server FQDN: `${azurerm_sql_server.postgresql.fqdn}`
* SQL Server Username/Password: `${azurerm_postgresql_server.sql.administrator_login}\\${azurerm_postgresql_server.sql.administrator_login_password}`
* Subscription ID: `${data.azurerm_client_config.current.subscription_id}`
* Resource Group Name: `${azurerm_virtual_machine.main.resource_group_name}`
* VM Name: `${azurerm_virtual_machine.main.name}`
* JWT Token: `jwt=`curl http://localhost:50342/oauth2/token?resource=https://management.azure.com -H metadata:true | jq .access_token | tr -d '\"'`
