## 3.0 HashiCorp Terraform - Variables
Create seperate Terraform files for Variables

### 3.0 Tasks
* Create variables.tf file with a variables for Azure location, Tags, and Vault Binary URL.
* Update main.tf file to use Azure location variable for the Resource Group.

* https://www.terraform.io/docs/configuration/variables.html

## 3.1 HashiCorp Terraform - Outputs
Create seperate Terraform files for Outputs

### 3.1 Tasks
* Create a file called outputs.tf file with an output called "download vault" that has a value which includes the vault_url variable you created in the prior task.

* https://www.terraform.io/docs/configuration/outputs.html

`sudo wget ${var.vault_url} -P /usr/local/bin/vault; sudo chmod 755 /usr/local/bin/vault`

## 3.2 HashiCorp Terraform - Locals
Add tags local

### 3.2 Tasks
* Create a local named tags which uses the merge function to merge the tags varaible created in 3.0 with a tag named ProjectName that has the value of your project name.
* Update the Resource Group with the tags local.

* https://www.terraform.io/docs/configuration/locals.html
* https://www.terraform.io/docs/configuration-0-11/interpolation.html
