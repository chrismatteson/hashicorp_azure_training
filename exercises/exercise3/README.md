## 3.0 HashiCorp Terraform - Variables
Create seperate Terraform files for Variables

### 3.0 Tasks
Create variables.tf file with a variables for Azure location and Vault Binary URL

https://www.terraform.io/docs/configuration/variables.html

## 3.1 HashiCorp Terraform - Outputs
Create seperate Terraform files for Outputs
Create outputs.tf file with useful information.

### 3.1 Tasks
Create a file called outputs.tf file with an output that has a value which includes the vault_url variable you created in the prior task.

https://www.terraform.io/docs/configuration/outputs.html

`sudo wget ${var.vault_url} -P /usr/local/bin/vault; sudo chmod 755 /usr/local/bin/vault`

