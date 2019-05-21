## 2.0 HashiCorp Terraform - Azure Networking
Setup Azure network

### 2.0 Tasks
* Create a Virtual Network, Subnet, Public IP and Network Interface. Tie them together with interpolation.

https://www.terraform.io/docs/providers/azurerm/r/virtual_network.html  
https://www.terraform.io/docs/providers/azurerm/r/subnet.html  
https://www.terraform.io/docs/providers/azurerm/r/public_ip.html  
https://www.terraform.io/docs/providers/azurerm/r/network_interface.html  
https://www.terraform.io/docs/configuration-0-11/interpolation.html  

`HINT 1: Terraform currently provides both a standalone Subnet resource, and allows for Subnets to be defined in-line within the Virtual Network resource. We DO NOT want to create in-line subnets so we can complete Exercise 2.1`

`HINT 2: Terraform docs site examples for more complicated resources often include the code for the simplier resources as well, so sometimes it's easier to copy/paste from the example for the last resource you want to create than starting with the first`

## 2.1 HashiCorp Terraform - Count
Create multiple resources without duplicating code

### 2.1 Tasks
* Update Subnet to use a count of 3. Use count.index to ensure each subnet has a unique address space.

https://www.terraform.io/intro/examples/count.html  
https://www.terraform.io/docs/configuration-0-11/interpolation.html  
