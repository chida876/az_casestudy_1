# Resource Group
resource_group_name  = "my-resource-group"
primary_region       = "East US"

# Recovery Services Vault
recovery_vault_name  = "my-recovery-vault"

# SQL Server
primary_sql_server_name = "my-primary-sql-server"
sql_admin_username      = "sqladmin"
sql_admin_password      = "StrongPassword123!"

# SQL Database
primary_sql_db_name = "my-primary-sql-db"

# Storage Account
primary_storage_account_name = "mystorageaccount"

# Virtual Network
vnet_name            = "my-vnet"
vnet_address_space   = ["10.0.0.0/16"]

# Subnet
subnet_name               = "my-subnet"
subnet_address_prefixes   = ["10.0.1.0/24"]

# Virtual Machine
my_vm_name          = "my-primary-vm"
vm_admin_username   = "vmadmin"
vm_admin_password   = "VMStrongPassword123!"
