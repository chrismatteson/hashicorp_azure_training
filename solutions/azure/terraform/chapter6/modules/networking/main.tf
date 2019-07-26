# Azure Networking Resources
resource "azurerm_virtual_network" "main" {
  name                = "${var.project_name}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.rg_name
}

resource "azurerm_subnet" "main" {
  count                = 3
  name                 = "${var.project_name}-subnet-${count.index}"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefix       = "10.0.${count.index + 1}.0/24"
}

resource "azurerm_public_ip" "main" {
  name                = "${var.project_name}-pubip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "main" {
  name                = "${var.project_name}-nic"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "config1"
    subnet_id                     = azurerm_subnet.main[0].id
    public_ip_address_id          = azurerm_public_ip.main.id
    private_ip_address_allocation = "dynamic"
  }
}

