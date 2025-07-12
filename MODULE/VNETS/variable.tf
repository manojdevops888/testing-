variable "VNET1_name" {
  description = "ziddi-vnet"
  type = string
}

variable "VNET1_location" {
  description = "west us"
  type = string
}

variable "resource_group_name" {
  description = "ziddi-rg"
  type = string
}
variable "address_space" {
  
type = list(string)
}