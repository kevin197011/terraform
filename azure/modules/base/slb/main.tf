resource "azurerm_lb" "lb" {
  resource_group_name = var.resource_group_name
  name                = var.lb_name
  location            = var.location
  sku                 = "basic"
  tags = {
    environment = var.tags
  }

  frontend_ip_configuration {
    name                          = "LoadBalancerFrontEnd"
    public_ip_address_id          = var.public_ip_address_id
  }
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.lb.id
  name                = "BackendPool1"
}

resource "azurerm_lb_rule" "lb_rule_80" {
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "lb-rule-80"
  protocol                       = "tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "LoadBalancerFrontEnd"
  enable_floating_ip             = false
  backend_address_pool_id        = azurerm_lb_backend_address_pool.backend_pool.id
  idle_timeout_in_minutes        = 5
  probe_id                       = azurerm_lb_probe.lb_probe_80.id
  depends_on                     = ["azurerm_lb_probe.lb_probe_80"]
}

resource "azurerm_lb_rule" "lb_rule_443" {
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "lb-rule-443"
  protocol                       = "tcp"
  frontend_port                  = 443
  backend_port                   = 443
  frontend_ip_configuration_name = "LoadBalancerFrontEnd"
  enable_floating_ip             = false
  backend_address_pool_id        = azurerm_lb_backend_address_pool.backend_pool.id
  idle_timeout_in_minutes        = 5
  probe_id                       = azurerm_lb_probe.lb_probe_443.id
  depends_on                     = ["azurerm_lb_probe.lb_probe_443"]
}

resource "azurerm_lb_probe" "lb_probe_80" {
  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.lb.id
  name                = "tcp-probe-80"
  protocol            = "tcp"
  port                = "80"
  interval_in_seconds = 5
  number_of_probes    = 2
}

resource "azurerm_lb_probe" "lb_probe_443" {
  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.lb.id
  name                = "tcp-probe-443"
  protocol            = "tcp"
  port                = "443"
  interval_in_seconds = 5
  number_of_probes    = 2
}
