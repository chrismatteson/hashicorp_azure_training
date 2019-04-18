## 5.0 HashiCorp Terraform - Azure AD
Create Azure AD resources

### 5.0 Tasks
* Create azuread_application, azuread_service_principal, and azuread_service_principal_password.

https://www.terraform.io/docs/providers/azuread/r/application.html
https://www.terraform.io/docs/providers/azuread/r/service_principal.html
https://www.terraform.io/docs/providers/azuread/r/service_principal_password.htm
https://www.terraform.io/docs/providers/azurerm/r/role_assignment.html

`HINT 1: Use azurerm_role_defintion data source from prior exercise for the role_definition_id.`

`HINT 2: Create a new random_id for client_secret.`
