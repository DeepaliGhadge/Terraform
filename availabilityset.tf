#create availability_set for application VMs
resource "azurerm_availability_set" "avset" {
  name                = "avset"
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.example.name
  platform_fault_domain_count  = 3
  platform_update_domain_count = 3
  managed                      = true
  tags = {
    environment = "Testing"
  }
  }