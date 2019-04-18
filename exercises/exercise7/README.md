## 7.0 HashiCorp Terraform - Enterprise
Migrate code to Terraform Enterprise for UI and Sentinel

### 7.0 Tasks
* Create a Terraform Enterprise trial account. The instructor will provide you with a link to create a 30 day trial.
* Create a new organization
* Create an API key for your user

https://www.hashicorp.com/products/terraform  
https://www.hashicorp.com/resources/why-consider-terraform-enterprise-over-open-source  
https://www.hashicorp.com/resources/getting-started-with-terraform-enterprise  
https://www.terraform.io/docs/enterprise/users-teams-organizations/users.html  

## 7.1 HashiCorp Terraform - Remote State
Configure remote state

### 7.1 Tasks
* Configure a .terraformrc file with the token created in the last task
* Create a terraform.tf file with remote backend configuration
* Run terraform init and copy state file to new backend
* Move old terraform.state file out of the directory
* Login to Terraform Enterprise and see the new workspace

https://www.terraform.io/docs/commands/cli-config.html  
https://www.terraform.io/docs/backends/types/remote.html  
https://app.terraform.io  

## 7.2 HashiCorp Terraform - Cloud Credentails
Provide cloud credentials to TFE workspace

### 7.2 Tasks
* Navigate to Variables tab of workspace and create the following variables and populate with data from your current state file

`ARM_CLIENT_ID: azuread_application.vaultapp.application_id`  
`ARM_TENANT_ID: azurerm_client_config.current.tenant_id`  
`ARM_SUBSCRIPTION_ID: azurerm_client_config.current.subscription_id`  
`ARM_CLIENT_SECRET: azuread_service_principal_password.vaultapp.value`  

`HINT 1: Click "Sensitive" after entering the value for ARM_CLIENT_SECRET to prevent accidential exposure`

## 7.3 HashiCorp Terraform - Remote Runs
Use remote backend

### 7.3 Tasks
* Run a terraform plan and apply and see what is new.
* View run status in UI
* Trigger a Plan from the UI

## 7.4 HashiCorp Terraform - Sentinel
Use sentinel to provide Policy as Code for Terraform

### 7.4 Tasks
* Create Sentinel Policy to enforce tags on azurerm_resource_group resources
* Create a Sentinel Policy Set for just the current workspace and configure the policy to use that policy set

https://www.terraform.io/docs/enterprise/sentinel/index.html  
