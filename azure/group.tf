module "devops_resource_group" {
  source              = "./modules/base/resource_group"
  resource_group_name = var.name
  location            = var.location
  tags                = var.name
}

module "devops_network" {
  source                = "./modules/base/network"
  resource_group_name   = module.devops_resource_group.resource_group_name
  location              = var.location
  tags                  = var.name
  network_name          = "${var.name}-vnet"
  network_address_space = "172.16.0.0/16"
  subnet_name           = "${var.name}-snet"
  subnet_address_prefix = "172.16.1.0/24"
}

