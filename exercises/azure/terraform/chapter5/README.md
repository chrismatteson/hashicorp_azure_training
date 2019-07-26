### Chapter 5 - Exercise 1 - Modules
* Create a subfolder called "modules" and another subfolder called "network"
* Write a variables.tf, main.tf, and outputs.tf file in this folder and move the code for all of the azure networking components from the root module into here.
* Write module code in the root module to call this new module and remove the networking code from the root.

https://www.terraform.io/docs/configuration/modules.html  

`HINT 1: Use variables to pass in information regarding the resource group and project_name`

`HINT 2: Create an output for network_interface id to be used in a later exercise.`

### Chapter 5 - Exercise 2 - Virtual Machine
* Create an Azure Virtual Machine to use the resource group, network interface, and template_file as custom_data, which were created in prior exercises.
* Add the MSI virtual machine extension to the VM created in the prior exercise.

https://www.terraform.io/docs/providers/azurerm/r/virtual_machine.html  
https://www.terraform.io/docs/providers/azurerm/r/virtual_machine_extension.html  
https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/overview  

`HINT 1: Use vm_size Standard_A2_v2.`

`HINT 2: Use the publisher "Microsoft.ManagedIdentity", the type "ManagedIdentityExtensionForLinux" and type_handler_version "1.0"`

### Chapter 5 - Exercise 3 - MySQL Server
* Create a managed MySQL Server Instance and Database. Create a new random_id to provide the password.
* Create a firewall rule to allow access from the public IP of our virtual machine

https://www.terraform.io/docs/providers/azurerm/r/mysql_server.html  
https://www.terraform.io/docs/providers/azurerm/r/mysql_database.html  
https://www.terraform.io/docs/providers/azurerm/r/mysql_firewall_rule.html  

### Chapter 5 - Exercise 4 - Add Useful Outputs
* Add outputs for to ease using the Terraform code.

https://www.terraform.io/docs/configuration/outputs.html

* Configure Vault: `export VAULT_ADDR=http://${azurerm_public_ip.main.ip_address}:8200`
* SQL Server FQDN: `${azurerm_mysql_server.sql.fqdn}`
* SQL Server Username: `${azurerm_mysql_server.sql.administrator_login}@${azurerm_mysql_server.sql.name}`
* SQL Server Password: `${azurerm_postgresql_server.sql.administrator_login_password}`
* Subscription ID: `${data.azurerm_client_config.current.subscription_id}`
* Resource Group Name: `${azurerm_virtual_machine.main.resource_group_name}`
* VM Name: `${azurerm_virtual_machine.main.name}`
* JWT Token: `jwt=`curl http://localhost:50342/oauth2/token?resource=https://management.azure.com -H metadata:true | jq .access_token | tr -d '\"'`
