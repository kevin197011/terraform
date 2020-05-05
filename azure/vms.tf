module "devops_security_ops" {
  source                      = "./modules/base/security"
  resource_group_name         = module.devops_resource_group.resource_group_name
  location                    = var.location
  tags                        = var.name
  network_security_group_name = "${var.name}-nsg-ops"
  security_rule_ports         = var.security_rule_ops
}

module "devops_public_ip_ops_01" {
  source              = "./modules/base/public_ip"
  resource_group_name = module.devops_resource_group.resource_group_name
  location            = var.location
  tags                = var.name
  public_ip_name      = "${var.name}-public-ip-ops-01"
}

module "devops_vm_ops_01" {
  source               = "./modules/base/vm_interface"
  resource_group_name  = module.devops_resource_group.resource_group_name
  location             = var.location
  tags                 = var.name
  node_name            = "devops-ops-node-01"
  node_private_ip      = "172.16.1.201"
  vm_size              = "Standard_F4s_v2"
  nsg_id               = module.devops_security_ops.network_security_group_id
  subnet_id            = module.devops_network.subnet_id
  public_ip_address_id = module.devops_public_ip_ops_01.public_ip_address_id
  node_hostname        = "devops-ops-node-01"

  # backend_pool_id         = module.devops_slb.backend_pool_id
  # availability_set_id     = module.devops_avset.availability_set_id
  admin_username = "ops"
  admin_password = "xxxxxx"
}

