## 1.0 HashiCorp Terraform - Resource Groups
Create resource groups in Azure

### 1.0 Tasks
Write Terraform code to create a resource group

https://www.terraform.io/intro/index.html
https://www.terraform.io/docs/commands/init.html
https://www.terraform.io/docs/commands/plan.html
https://www.terraform.io/docs/commands/apply.html
https://www.terraform.io/docs/providers/azurerm/r/resource_group.html

`HINT 1: If you want your code to be completely reusable, use random_id to generate unique names. For instance, we could create a resource "random_id" "project_name" and use intepolation to pass ${random_id.project_name.hex} as the input to any name fields. https://www.terraform.io/docs/providers/random/r/id.html`
