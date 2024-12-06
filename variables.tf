# Resource Group
variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "primary_region" {
  description = "Azure region for the primary infrastructure"
  type        = string
}

# Recovery Services Vault
variable "recovery_vault_name" {
  description = "Name of the Recovery Services Vault"
  type        = string
}

# SQL Server
variable "primary_sql_server_name" {
  description = "Name of the primary SQL server"
  type        = string
}

variable "sql_admin_username" {
  description = "Administrator username for SQL server"
  type        = string
}

variable "sql_admin_password" {
  description = "Administrator password for SQL server"
  type        = string
  sensitive   = true
}

# SQL Database
variable "primary_sql_db_name" {
  description = "Name of the primary SQL database"
  type        = string
}

# Storage Account
variable "primary_storage_account_name" {
  description = "Name of the primary storage account"
  type        = string
}

# Virtual Network
variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the Virtual Network"
  type        = list(string)
}

# Subnet
variable "subnet_name" {
  description = "Name of the Subnet"
  type        = string
}

variable "subnet_address_prefixes" {
  description = "Address prefixes for the Subnet"
  type        = list(string)
}

# Virtual Machine
variable "my_vm_name" {
  description = "Name of the Virtual Machine"
  type        = string
}

variable "vm_admin_username" {
  description = "Administrator username for the Virtual Machine"
  type        = string
}

variable "vm_admin_password" {
  description = "Administrator password for the Virtual Machine"
  type        = string
  sensitive   = true
}
