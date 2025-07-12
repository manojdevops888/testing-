variable "sql_server_name" {
  description = "The name of the SQL Server"
  type        = string
}

variable "sql_server_admin_login" {
  description = "The administrator login for the SQL Server"
  type        = string
}

variable "sql_server_admin_password" {
  description = "The administrator password for the SQL Server"
  type        = string
}
variable "resource_group_name" {
  description = "The name of the Resource Group where the SQL Server will be created"
  type        = string
  
}
variable "location" {
  description = "The Azure Region where the SQL Server will be created"
  type        = string
  
}