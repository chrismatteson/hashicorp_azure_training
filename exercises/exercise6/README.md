## 6.0 HashiCorp Terraform - Virtual Machine
Create an Azure Virtual Machine

### 6.0 Tasks
Create an Azure Virtual Machine to use the resource group, and, network interface created in prior exercises.

https://www.terraform.io/docs/providers/azurerm/r/virtual_machine.html

`HINT 1: Use vm_size Standard_A2_v2.`

## 6.1 HashiCorp Terraform - Virtual Machine Extension
Create VM extension

### 6.1 Tasks
Add the MSI virtual machine extension to the VM created in the prior exercise.

https://www.terraform.io/docs/providers/azurerm/r/virtual_machine_extension.html
https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/overview

`HINT 1: Use the publisher "Microsoft.ManagedIdentity", the type "ManagedIdentityExtensionForLinux" and type_handler_version "1.0"`
