### Chapter 3 - Exercise 1 - Setup Azure Network
* Create a Virtual Network, Subnet, Public IP and Network Interface. Tie them together with interpolation.

https://www.terraform.io/docs/providers/azurerm/r/virtual_network.html  
https://www.terraform.io/docs/providers/azurerm/r/subnet.html  
https://www.terraform.io/docs/providers/azurerm/r/public_ip.html  
https://www.terraform.io/docs/providers/azurerm/r/network_interface.html  
https://www.terraform.io/docs/configuration-0-11/interpolation.html  

`HINT 1: Terraform currently provides both a standalone Subnet resource, and allows for Subnets to be defined in-line within the Virtual Network resource. We DO NOT want to create in-line subnets so we can complete Exercise 2.1`

`HINT 2: Terraform docs site examples for more complicated resources often include the code for the simplier resources as well, so sometimes it's easier to copy/paste from the example for the last resource you want to create than starting with the first`

### Chapter 3 - Exercise 2 - Count
* Update Subnet to use a count of 3. Use count.index to ensure each subnet has a unique address space.

https://www.terraform.io/intro/examples/count.html  
https://www.terraform.io/docs/configuration-0-11/interpolation.html  

### Chapter 3 - Exercise 3 - Variables
* Create variables.tf file with a variables for Azure location, Tags, and Vault Binary URL.
* Update main.tf file to use Azure location variable for the Resource Group.

https://www.terraform.io/docs/configuration/variables.html  

### Chapter 3 - Exercise 4 - Outputs
* Create a file called outputs.tf file with an output called "download vault" that has a value which includes the vault_url variable you created in the prior task.

https://www.terraform.io/docs/configuration/outputs.html  

`sudo wget ${var.vault_url} -P /usr/local/bin/vault; sudo chmod 755 /usr/local/bin/vault`  

### Chapter 3 - Exercise 5 - Locals
* Create a local named tags which uses the merge function to merge the tags varaible created in 3.0 with a tag named ProjectName that has the value of your project name.
* Update the Resource Group with the tags local.

https://www.terraform.io/docs/configuration/locals.html  
https://www.terraform.io/docs/configuration-0-11/interpolation.html  
