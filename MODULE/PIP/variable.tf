variable "pip_name" {
  description = "The name of the Public IP"
  type        = string
  
}
variable "resource_group_name" {
  description = "The name of the Resource Group where the Public IP will be created"
  type        = string
}
variable "location" {
  description = "The Azure Region where the Public IP will be created"
  type        = string
}
variable "allocation_method" {
  description = "The allocation method for the Public IP (Static or Dynamic)"
  type        = string
  default     = "Static"
}