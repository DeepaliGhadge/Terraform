variable "resource_group_location" {
  default     = "Central India"
  description = "Location of the resource group."
}

variable "resource_group_name" {
  default     = "WTResourceGroupBONUS"
  description = "Resource Group name."
}


variable "app_vm_count" {
  default     = "3"
  description = "vm count."
}


variable "address_space" {
   default       = ["10.0.0.0/16"]
   description = "Address space for virtual network."
   }

variable "admin_username" {
  description = "VM administrator username"
  type        = string
  default     = "deepalig"
  sensitive   = true
}

variable "admin_password" {
  description = "VM administrator password"
  type        = string
  default     = "Sela@123"
  sensitive   = true
}

variable "saname" {
  type = string
  description = ""
  default = ""
}