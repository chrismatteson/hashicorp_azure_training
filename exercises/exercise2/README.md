## 2.0 HashiCorp Terraform - Azure Networking
Setup Azure network

### 2.0 Tasks
Create a Virtual Network, Subnet, Public IP and Network Interface. Tie them together with interpolation.

https://www.terraform.io/docs/providers/azurerm/r/virtual_network.html
https://www.terraform.io/docs/providers/azurerm/r/subnet.html
https://www.terraform.io/docs/providers/azurerm/r/public_ip.html
https://www.terraform.io/docs/providers/azurerm/r/network_interface.html
https://www.terraform.io/docs/configuration-0-11/interpolation.html

`HINT 1: If you want your code to be completely reusable, use random_id to generate unique names. For instance, we could create a resource "random_id" "project_name" and use intepolation to pass ${random_id.project_name.hex} as the input to any name fields. https://www.terraform.io/docs/providers/random/r/id.html`
