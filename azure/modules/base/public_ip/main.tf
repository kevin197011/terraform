resource "azurerm_public_ip" "public_ip" {
    name                         = var.public_ip_name
    location                     = var.location
    resource_group_name          = var.resource_group_name
    allocation_method            = "Static"

    tags = {
        environment = var.tags
    }
}