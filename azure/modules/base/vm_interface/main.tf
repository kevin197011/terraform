# Create network interface
resource "azurerm_network_interface" "network_interface" {
  name                      = "${var.node_name}-nic"
  location                  = var.location
  resource_group_name       = var.resource_group_name
  network_security_group_id = var.nsg_id
  // enable_accelerated_networking = true

  ip_configuration {
    name                                    = "${var.node_name}_nic_config"
    subnet_id                               = var.subnet_id
    private_ip_address_allocation           = "Static"
    private_ip_address                      = var.node_private_ip
    public_ip_address_id                    = var.public_ip_address_id
    load_balancer_backend_address_pools_ids = [var.backend_pool_id]
  }

  tags = {
    environment = var.tags
  }
}

# Create virtual machine
resource "azurerm_virtual_machine" "virtual_machine" {
  name                  = var.node_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  availability_set_id   = var.availability_set_id
  network_interface_ids = [azurerm_network_interface.network_interface.id]
  vm_size               = var.vm_size

  storage_os_disk {
    name              = "${var.node_name}-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    disk_size_gb      = 50
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.5"
    version   = "latest"
  }

  os_profile {
    computer_name  = var.node_hostname
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    environment = var.tags
  }
}