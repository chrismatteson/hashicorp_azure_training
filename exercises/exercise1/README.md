## 1.0 HashiCorp Terraform - Resource Groups
Create resource groups in Azure

### 1.0 Tasks
* Write Terraform code to create a resource group
* Explicitely state the azurerm provider using the provider syntax

https://www.terraform.io/intro/index.html  
https://www.terraform.io/docs/commands/init.html  
https://www.terraform.io/docs/commands/plan.html  
https://www.terraform.io/docs/commands/apply.html  
https://www.terraform.io/docs/providers/azurerm/r/resource_group.html  
https://www.terraform.io/docs/configuration/providers.html  

`HINT 1: If you want your code to be completely reusable, use random_id to generate unique names. For instance, we could create a resource "random_id" "project_name" and use intepolation to pass ${random_id.project_name.hex} as the input to any name fields. https://www.terraform.io/docs/providers/random/r/id.html`

## 1.1 HashiCorp Terraform - State
Manage State

### 1.1 Tasks
* Use Terraform command line tool to view all of the state at once. Compare to looking at the state file directly in a text editer.
* Use Terraform command line tool to view the Resource Graph.
* Use Terraform command line tool to remove the Resource Group created in task 1.0 from the state file. Show that a Terraform plan now wants to recreate the Resource Group
* Use Terraform command line tool to import the Resource Group back into the state file. Show that a Terraform plan does not want to make any changes.
* Use Terraform command line tool to taint the Resource Group in the state file. Show that a Terraform plan now wants to recreate the Resource Group. Untaint the Resource Group and show that a Terraform plan no longer wants to make any changes.
* Use Terraform command line tool to destroy everything.
* Use Terraform command line tool to recreate just the random_id using target.

https://www.terraform.io/docs/import  
https://www.terraform.io/docs/state/index.html  
https://www.terraform.io/docs/commands  
