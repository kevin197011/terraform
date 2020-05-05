
resource "azurerm_network_security_group" "network_security_group" {
  name                = var.network_security_group_name
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = {
    environment = var.tags
  }
}

resource "azurerm_network_security_rule" "network_security_rule" {
  name                        = lookup(var.security_rule_ports[count.index], "name")
  priority                    = 1000 + count.index
  direction                   = "Inbound"
  access                      = lookup(var.security_rule_ports[count.index], "action")
  source_port_range           = "*"
  destination_port_range      = lookup(var.security_rule_ports[count.index], "port")
  source_address_prefix       = lookup(var.security_rule_ports[count.index], "source")
  destination_address_prefix  = lookup(var.security_rule_ports[count.index], "description")
  count                       = length(var.security_rule_ports)
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.network_security_group.name
  protocol                    = "Tcp"
}