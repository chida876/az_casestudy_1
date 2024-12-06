provider "azurerm" {
  features {}
  subscription_id = "fc6b7a65-900d-4ecd-ac15-5db3ba323e37"
  client_id       = "1fbe0096-9305-4b80-b320-44e56b259117"
  client_secret   = "NdY8Q~LR4UocVXBGSqDU3~7pxHNY98xc3qDWUad7"
  tenant_id       = "a830f80b-24da-4ded-b68d-957f8c2d861d"
}


# Resource Group for DR Infrastructure
resource "azurerm_resource_group" "my_resource_group" {
  name     = var.resource_group_name
  location = var.primary_region
}

# SQL Server Setup (Primary) - Use azurerm_mssql_server
resource "azurerm_mssql_server" "primary_sql_server" {
  name                         = var.primary_sql_server_name
  resource_group_name          = azurerm_resource_group.my_resource_group.name
  location                     = azurerm_resource_group.my_resource_group.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password
}

# SQL Database Setup (Primary) - Use azurerm_mssql_database
resource "azurerm_mssql_database" "primary_sql_db" {
  name          = var.primary_sql_db_name
  server_id     = azurerm_mssql_server.primary_sql_server.id
  collation     = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb   = 10
 # requested_service_objective_name = "S1"  # Use requested service objective instead of SKU
}

# Storage Account (Primary)
resource "azurerm_storage_account" "primary_storage_account" {
  name                     = var.primary_storage_account_name
  resource_group_name      = azurerm_resource_group.my_resource_group.name
  location                 = azurerm_resource_group.my_resource_group.location
  account_tier              = "Standard"
  account_replication_type = "GRS"  # Geo-redundant storage
}

# Virtual Network Setup (Primary)
resource "azurerm_virtual_network" "my_vnet" {
  name                = "my-vnet"
  location            = azurerm_resource_group.my_resource_group.location
  resource_group_name = azurerm_resource_group.my_resource_group.name
  address_space       = ["10.0.0.0/16"]
}

# Subnet Setup (Primary)
resource "azurerm_subnet" "my_subnet" {
  name                 = "my-subnet"
  resource_group_name  = azurerm_resource_group.my_resource_group.name
  virtual_network_name = azurerm_virtual_network.my_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Network Interface Setup (Primary)
resource "azurerm_network_interface" "my_vm_nic" {
  name                = "${var.my_vm_name}-nic"
  location            = azurerm_resource_group.my_resource_group.location
  resource_group_name = azurerm_resource_group.my_resource_group.name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.my_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Virtual Machine Setup (Primary)
resource "azurerm_virtual_machine" "my_vm" {
  name                  = var.my_vm_name
  resource_group_name   = azurerm_resource_group.my_resource_group.name
  location              = azurerm_resource_group.my_resource_group.location
  network_interface_ids = [azurerm_network_interface.my_vm_nic.id]
  vm_size               = "Standard_D2_v3"
  storage_os_disk {
    name              = "primary-os-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "my-vm"
    admin_username = var.vm_admin_username
    admin_password = var.vm_admin_password
  }
}

