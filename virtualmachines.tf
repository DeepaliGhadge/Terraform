#create VMs for Applicaion
  resource "azurerm_virtual_machine" "test" {
   count                 = 3
   name                  = "acctvm${count.index}"
   location              = var.resource_group_location
   availability_set_id   = azurerm_availability_set.avset.id
   resource_group_name   = var.resource_group_name
   network_interface_ids = [element(azurerm_network_interface.tf-nic.*.id, count.index)]
   vm_size               = "Standard_B1s"

   # Uncomment this line to delete the OS disk automatically when deleting the VM
   delete_os_disk_on_termination = true

   # Uncomment this line to delete the data disks automatically when deleting the VM
   delete_data_disks_on_termination = true

   storage_image_reference {
     publisher = "Canonical"
     offer     = "UbuntuServer"
     sku       = "18.04-LTS"
     version   = "latest"
   }

   storage_os_disk {
     name              = "myosdisk${count.index}"
     caching           = "ReadWrite"
     create_option     = "FromImage"
     managed_disk_type = "Standard_LRS"
   }

    storage_data_disk {
     name            = element(azurerm_managed_disk.test.*.name, count.index)
     managed_disk_id = element(azurerm_managed_disk.test.*.id, count.index)
     create_option   = "Attach"
     lun             = 1
     disk_size_gb    = element(azurerm_managed_disk.test.*.disk_size_gb, count.index)
   }

   os_profile {
     computer_name  = "Appserver"
     admin_username = var.admin_username
     admin_password = var.admin_password
    }

   os_profile_linux_config {
     disable_password_authentication = false
   }
   }


#create VMs for DB
  resource "azurerm_virtual_machine" "test2" {
   count                 = 1
   name                  = "dbvm${count.index}"
   location              = var.resource_group_location
   #availability_set_id   = azurerm_availability_set.avset.id
   resource_group_name   = var.resource_group_name
   network_interface_ids = [element(azurerm_network_interface.test2.*.id, count.index)]
   vm_size               = "Standard_B1s"

   # Uncomment this line to delete the OS disk automatically when deleting the VM
   delete_os_disk_on_termination = true

   # Uncomment this line to delete the data disks automatically when deleting the VM
   delete_data_disks_on_termination = true

   storage_image_reference {
     publisher = "Canonical"
     offer     = "UbuntuServer"
     sku       = "18.04-LTS"
     version   = "latest"
   }

   storage_os_disk {
     name              = "myosdiskdb${count.index}"
     caching           = "ReadWrite"
     create_option     = "FromImage"
     managed_disk_type = "Standard_LRS"
   }

   storage_data_disk {
     name            = element(azurerm_managed_disk.test2.*.name, count.index)
     managed_disk_id = element(azurerm_managed_disk.test2.*.id, count.index)
     create_option   = "Attach"
     lun             = 1
     disk_size_gb    = element(azurerm_managed_disk.test2.*.disk_size_gb, count.index)
   }

   os_profile {
      computer_name  = "DBserver"
      admin_username = var.admin_username
      admin_password = var.admin_password
      }

   os_profile_linux_config {
     disable_password_authentication = false
   }
   }