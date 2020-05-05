resource "azurerm_virtual_network" "network" {
  name                = var.network_name
  address_space       = [var.network_address_space]
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = {
    environment = var.tags
  }
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefix       = var.subnet_address_prefix
}