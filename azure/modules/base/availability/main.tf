resource "azurerm_availability_set" "avset" {
 name                         = var.name
 location                     = var.location
 resource_group_name          = var.resource_group_name
 platform_fault_domain_count  = 2
 platform_update_domain_count = 2
 managed                      = true

  tags = {
    environment = var.tags
  }

}