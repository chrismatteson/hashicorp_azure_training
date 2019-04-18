## 2.0 HashiCorp Terraform - Azure Networking
Setup Azure network

### 2.0 Tasks
* Create a Virtual Network, Subnet, Public IP and Network Interface. Tie them together with interpolation.

https://www.terraform.io/docs/providers/azurerm/r/virtual_network.html
https://www.terraform.io/docs/providers/azurerm/r/subnet.html
https://www.terraform.io/docs/providers/azurerm/r/public_ip.html
https://www.terraform.io/docs/providers/azurerm/r/network_interface.html
https://www.terraform.io/docs/configuration-0-11/interpolation.html

## 2.1 HashiCorp Terraform - Count
Create multiple resources withour duplicating code

### 2.1 Tasks
* Update Subnet to use a count of 3. Use count.index to ensure each subnet has a unique address space.

https://www.terraform.io/intro/examples/count.html
https://www.terraform.io/docs/configuration-0-11/interpolation.html
