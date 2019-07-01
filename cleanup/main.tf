variable "groups" {}

resource "azurerm_resource_group" "groups" {
  count    = length(var.groups)
  location = "eastus"
  name     = element(var.groups, count.index)
}
