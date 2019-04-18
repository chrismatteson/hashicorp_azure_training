## 5.0 HashiCorp Terraform - Modules
Create a module for Azure AD resources

### 5.0 Tasks
* Create a subfolder called "modules" and another subfolder called "service_principal"
* Write a variables.tf, main.tf, and outputs.tf file in this folder to create an azuread_application, azuread_service_principal, and azuread_service_principal_password.

https://www.terraform.io/docs/configuration/modules.html  
https://www.terraform.io/docs/providers/azuread/r/application.html  
https://www.terraform.io/docs/providers/azuread/r/service_principal.html  
https://www.terraform.io/docs/providers/azuread/r/service_principal_password.html  
https://www.terraform.io/docs/providers/azurerm/r/role_assignment.html  

`HINT 1: Use azurerm_role_defintion data source from prior exercise for the role_definition_id.`

`HINT 2: Create a new random_id for client_secret.`

`Hint 3: You'll need inputs for resource_group, location, project_name, subscription_id and role_definition_id`

`Hint 4: You'll want to create outputs for application_id and service_principal_password`
