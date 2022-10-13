output "vm_username" {
  description = "VM administrator username"
  value       = var.admin_username
  sensitive   = true
}

output "vm_password" {
  description = "VM administrator password"
  value       = var.admin_password
  sensitive   = true
}

output "resource_group_name" {
  value = azurerm_resource_group.example.name
}

#output "public_ip_address" {
 # value = azurerm_lb.test.public_ip_address
#}

