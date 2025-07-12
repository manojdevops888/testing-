variable "sql_database_name" {
  description = "The name of the SQL Database"
  type        = string
}
variable "sql_server_id" {
  description = "The ID of the SQL Server where the database will be created"
  type        = string
}
variable "collation" {
  description = "The collation for the SQL Database"
  type        = string
}