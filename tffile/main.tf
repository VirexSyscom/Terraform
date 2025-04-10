resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = random_pet.rg_name.id
}

# Create virtual network
resource "azurerm_virtual_network" "my_terraform_network" {
  name                = "VirtualNet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create subnet
resource "azurerm_subnet" "my_terraform_subnet" {
  name                 = "VMSubNet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.my_terraform_network.name
  address_prefixes     = ["10.0.1.0/24"]
}




# Create public IP1s
resource "azurerm_public_ip" "my_terraform_public_ip1" {
  name                = "PublicIP1"
  sku                 = "Standard"
  sku_tier            = "Regional"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
        allocation_method   = "Static"
}

# Create public IP2s
resource "azurerm_public_ip" "my_terraform_public_ip2" {
  name                = "PublicIP2"
  sku                 = "Standard"
  sku_tier            = "Regional"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
        allocation_method   = "Static"
}



# Create Network Security Group and rule 1
resource "azurerm_network_security_group" "my_terraform_nsg1" {
  name                = "NetworkSecurityGroup1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Create Network Security Group and rule 2
resource "azurerm_network_security_group" "my_terraform_nsg2" {
  name                = "NetworkSecurityGroup2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}





# Create network interface 1
resource "azurerm_network_interface" "my_terraform_nic1" {
  name                = "NIC1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "nic_configuration"
    subnet_id                     = azurerm_subnet.my_terraform_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.my_terraform_public_ip1.id
  }
}


# Create network interface 2
resource "azurerm_network_interface" "my_terraform_nic2" {
  name                = "NIC2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "nic_configuration"
    subnet_id                     = azurerm_subnet.my_terraform_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.my_terraform_public_ip2.id
  }
}





# Connect the security group to the network interface1
resource "azurerm_network_interface_security_group_association" "example1" {
  network_interface_id      = azurerm_network_interface.my_terraform_nic1.id
  network_security_group_id = azurerm_network_security_group.my_terraform_nsg1.id
}

# Connect the security group to the network interface2
resource "azurerm_network_interface_security_group_association" "example2" {
  network_interface_id      = azurerm_network_interface.my_terraform_nic2.id
  network_security_group_id = azurerm_network_security_group.my_terraform_nsg2.id
}



# Generate random text for a unique storage account name
resource "random_id" "random_id" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = azurerm_resource_group.rg.name
  }

  byte_length = 8
}



# Create storage account for boot diagnostics1
resource "azurerm_storage_account" "my_storage_account1" {
  name                     = "diag${random_id.random_id.hex}1"
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create storage account for boot diagnostics2
resource "azurerm_storage_account" "my_storage_account2" {
  name                     = "diag${random_id.random_id.hex}2"
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}



# Create virtual machine1
resource "azurerm_linux_virtual_machine" "my_terraform_vm1" {
  name                  = "AzVM1"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.my_terraform_nic1.id]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "myOsDisk1"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  computer_name  = "hostname"
  admin_username = var.username

  admin_ssh_key {
    username   = var.username
    public_key = azapi_resource_action.ssh_public_key_gen.output.publicKey
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.my_storage_account1.primary_blob_endpoint
  }
}



# Create virtual machine2
resource "azurerm_linux_virtual_machine" "my_terraform_vm2" {
  name                  = "AzVM2"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.my_terraform_nic2.id]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "myOsDisk2"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  computer_name  = "hostname"
  admin_username = var.username

  admin_ssh_key {
    username   = var.username
    public_key = azapi_resource_action.ssh_public_key_gen.output.publicKey
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.my_storage_account2.primary_blob_endpoint
  }
}