#create resource group
resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

#create virtual network
resource "azurerm_virtual_network" "test" {
   name                = "WTvn"
   address_space       = var.address_space
   location            = var.resource_group_location
   resource_group_name = azurerm_resource_group.example.name
 }


#create network subnet 1 for application - public
 resource "azurerm_subnet" "test1" {
   name                 = "Applicaionsubnet"
   resource_group_name  = var.resource_group_name
   virtual_network_name = azurerm_virtual_network.test.name
   address_prefixes     = ["10.0.2.0/24"]
   }

#create network subnet 2 for DB - private
  resource "azurerm_subnet" "test2" {
   name                 = "DBsubnet"
   resource_group_name  = var.resource_group_name
   virtual_network_name = azurerm_virtual_network.test.name
   address_prefixes     = ["10.0.1.0/24"]
 }


#

#create network_interface for Applicaion
  resource "azurerm_network_interface" "tf-nic" {
   count               = 3
   name                = "appni${count.index}"
   location            = var.resource_group_location
   resource_group_name = var.resource_group_name

   ip_configuration {
     name                          = "testConfiguration${count.index}"
     subnet_id                     = azurerm_subnet.test1.id
     private_ip_address_allocation = "dynamic"
   }
 }

# Create Network Security Group and rule
resource "azurerm_network_security_group" "example" {
  name                = "App-nsg"
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name                       = "AllowAnyCustom8080Inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "10.0.2.0/24"
  }

  security_rule {
    name                       = "AllowAnyCustom200-210Inbound"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Connect the security group to the network interface
resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.test1.id
  network_security_group_id = azurerm_network_security_group.example.id
}

#

# Disk for all Vms
resource "azurerm_managed_disk" "test" {
   count                = 3
   name                 = "datadisk_existing1_${count.index}"
   location             = var.resource_group_location
   resource_group_name  = azurerm_resource_group.example.name
   storage_account_type = "Standard_LRS"
   create_option        = "Empty"
   disk_size_gb         = "1023"
 }


#Create (and display) an SSH key
resource "tls_private_key" "example_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


module "tfstateremote"{
  source = "./modules"
}

#create network_interface for DB
  resource "azurerm_network_interface" "test2" {
   count               = 1
   name                = "dbni${count.index}"
   location            = var.resource_group_location
   resource_group_name = azurerm_resource_group.example.name

   ip_configuration {
     name                          = "testConfiguration2"
     subnet_id                     = azurerm_subnet.test2.id
     private_ip_address_allocation = "dynamic"
   }
 }

#Create Network Security Group and rule
resource "azurerm_network_security_group" "example1" {
  name                = "DB-nsg"
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name                       = "DBAccessrule0"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "8080"
    destination_port_range     = "22"
    source_address_prefix      = "122.170.248.40"
    destination_address_prefix = "*"
  }

   security_rule {
    name                       = "DBAccessrule1"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "8080"
    destination_port_range     = "5433"
    source_address_prefix      = "10.0.2.0/24"
    destination_address_prefix = "*"
  }
}

#Connect the security group to the network interface
resource "azurerm_subnet_network_security_group_association" "example1" {
  subnet_id                 = azurerm_subnet.test2.id
  network_security_group_id = azurerm_network_security_group.example1.id
}

#

# disk for DB VM
resource "azurerm_managed_disk" "test2" {
   count                = 1
   name                 = "datadisk_db_${count.index}"
   location             = var.resource_group_location
   resource_group_name  = azurerm_resource_group.example.name
   storage_account_type = "Standard_LRS"
   create_option        = "Empty"
   disk_size_gb         = "1023"
 }