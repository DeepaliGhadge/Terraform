#create public_ip for LB
resource "azurerm_public_ip" "test" {
   name                         = "publicIPForLB"
   location                     = var.resource_group_location
   resource_group_name          = azurerm_resource_group.example.name
   allocation_method            = "Static"
 }

# Creating public load balancer
 resource "azurerm_lb" "main" {
  name                = "WTloadbalancer"
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "Basic"
  frontend_ip_configuration {
    name                 = "lb-public-ip-config"
    public_ip_address_id = azurerm_public_ip.test.id
  }
  
  depends_on=[
    azurerm_resource_group.example
    ]

}


#Load balancer - Backend pools
resource "azurerm_lb_backend_address_pool" "main" {
  name            = "WTloadbalancer-bepool"
  loadbalancer_id = azurerm_lb.main.id
}

#Load balancer - Health probes
resource "azurerm_lb_probe" "main" {
  name            = "WTloadbalancer-health-probe"
  resource_group_name   = azurerm_resource_group.example.name
  loadbalancer_id = azurerm_lb.main.id
  port            = 8080
  }

#loadBalancer -  Load balancing rules
resource "azurerm_lb_rule" "main" {
  loadbalancer_id                = azurerm_lb.main.id
  name                           = "WTloadbalancer-rule"
  resource_group_name   = azurerm_resource_group.example.name
  protocol                       = "Tcp"
  frontend_port                  = 8080
  backend_port                   = 8080
  frontend_ip_configuration_name = "lb-public-ip-config"
  #backend_address_pool_ids      = [azurerm_lb_backend_address_pool.main.id]
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.scalesetpool.id]
  probe_id                       = azurerm_lb_probe.main.id
}

#load balancer NAT rule
resource "azurerm_lb_nat_rule" "main" {
  count                          = var.app_vm_count
  resource_group_name            = azurerm_resource_group.example.name
  loadbalancer_id                = azurerm_lb.main.id
  name                           = "lb-nat-ssh-${count.index}"
  protocol                       = "Tcp"
  frontend_port                  = "21${count.index}"
  backend_port                   = 22
  frontend_ip_configuration_name = "lb-public-ip-config"
}


resource "azurerm_lb_nat_pool" "lbnatpoolssh" {
  name                           = "ssh"
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.main.id
  protocol                       = "Tcp"
  frontend_port_start           = 200
  frontend_port_end              = 202
  backend_port                   = 22
  frontend_ip_configuration_name = "lb-public-ip-config"
}


#nat rule asssociation
resource "azurerm_network_interface_nat_rule_association" "main" {
  count                 = var.app_vm_count
  network_interface_id  = azurerm_network_interface.tf-nic[count.index].id
  ip_configuration_name = "testConfiguration${count.index}"
  nat_rule_id           = azurerm_lb_nat_rule.main[count.index].id
}


resource "azurerm_lb_backend_address_pool" "scalesetpool" {
  loadbalancer_id         = azurerm_lb.main.id
  name                    =  "scalesetpool"
   
  depends_on=[
    azurerm_lb.main
    ]

}


