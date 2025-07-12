variable "resource_group_name" {
  description = "The name of the Resource Group where the Virtual Machine will be created"
  type        = string
  
}
variable "location" {
  description = "The Azure Region where the Virtual Machine will be created"
  type        = string
  
}
variable "nic_name" {
  description = "The name of the Network Interface"
  type        = string
  
}
variable "subnet_id" {
  description = "The ID of the Subnet where the Network Interface will be created"
  type        = string
  
}
variable "vm_name" {
  description = "The name of the Virtual Machine"
  type        = string
  
}
variable "vm_size" {
  description = "The size of the Virtual Machine"
  type        = string

}
variable "admin_username" {
  description = "The admin username for the Virtual Machine"
  type        = string
  

}
variable "admin_password" {
  description = "The admin password for the Virtual Machine"
  type        = string

}
variable "image_publisher" {
  description = "The publisher of the image to use for the Virtual Machine"
  type        = string
 
}
variable "sku" {
  description = "The SKU of the image to use for the Virtual Machine"
  type        = string
 
}

variable "offer" {
  description = "value for offer"
  type = string
}
variable "public_ip_id" {
  description = "The ID of the Public IP associated with the Virtual Machine"
  type        = string
  }
