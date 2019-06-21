## 5.0 HashiCorp Terraform - Modules
Create a module for Azure AD resources

### 5.0 Tasks
* Create a subfolder called "modules" and another subfolder called "network"
* Write a variables.tf, main.tf, and outputs.tf file in this folder and move the code for all of the azure networking components from the root module into here.
* Write module code in the root module to call this new module and remove the networking code from the root.

https://www.terraform.io/docs/configuration/modules.html  

`HINT 1: Use variables to pass in information regarding the resource group and project_name`

`HINT 2: Create an output for network_interface id to be used in a later exercise.`
