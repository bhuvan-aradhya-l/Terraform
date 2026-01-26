//Resource Group
//resource "azurerm_resource_group" "rg" {
//  location = var.location
//  name     = var.rg_name
//}

data "azurerm_resource_group" "rg" {
	name = "cligroup1-BAL"
}

//vNet
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = var.address_space
}

//Subnet
//resource "azurerm_subnet" "subnet" {
//	name = var.subnet_name
//	resource_group_name = azurerm_resource_group.rg.name
//	virtual_network_name = var.vnet_name
//	address_prefixes = var.address_prefixes
//	depends_on = [azurerm_virtual_network.vnet]
//}

//Multiple Subnet
resource "azurerm_subnet" "subnet" {
  count = length(var.address_prefix)

  name                 = var.address_prefix[count.index].name
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.address_prefix[count.index].address_prefixes
}

//NSG
resource "azurerm_network_security_group" "nsg" {
  name                = "acceptanceTestSecurityGroup-BAL"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  security_rule {
    name                       = "test-BAL-1"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "22"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Dev"
  }
}

//Public IP
resource "azurerm_public_ip" "pip" {
  name                = "acceptanceTestPublicIp"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  allocation_method   = "Static"
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    environment = "Dev"
  }
}

//NIC
resource "azurerm_network_interface" "nic" {
  name                = "tfnic-BAL"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet[1].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

//Associate NSG to NIC
resource "azurerm_network_interface_security_group_association" "nsg-nic-example-BAL" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

//SSH Key
//resource "azurerm_ssh_public_key" "sshk-BAL" {
//  name                = "tfsshk-BAL"
//  location            = azurerm_resource_group.rg.location
//  resource_group_name = azurerm_resource_group.rg.name
//  public_key          = file("~/.ssh/id_rsa.pub")
//}

//Linux Virtual Machine
//resource "azurerm_linux_virtual_machine" "vmtfBAL" {
//  name                = "vm-tf-BAL"
//  resource_group_name = azurerm_resource_group.rg.name
//  location            = azurerm_resource_group.rg.location
//  size                = "Standard_B2s_v2"
//  admin_username      = "azureuser"
//  network_interface_ids = [
//    azurerm_network_interface.nic.id
//  ]

//  lifecycle {
//    ignore_changes = [
//      size
//    ]
//  }

//  admin_ssh_key {
//    username   = "azureuser"
//    public_key = file("~/.ssh/id_rsa.pub")
//  }

//  os_disk {
//    caching              = "ReadWrite"
//    storage_account_type = "Standard_LRS"
//  }

//  source_image_reference {
//    publisher = "Canonical"
//    offer     = "0001-com-ubuntu-server-jammy"
//    sku       = "22_04-lts"
//    version   = "latest"
//  }
//}

//Windows Virtual Machine
resource "azurerm_windows_virtual_machine" "WinTFvm-BAL" {
	name = "Win-TF-BAL"
	resource_group_name = data.azurerm_resource_group.rg.name
	location 	    = data.azurerm_resource_group.rg.location
	size		    = "Standard_B2ats_v2"
	admin_username	    = "azureuser"
	admin_password      = "Aradhya2000"
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

//Storage Account
resource "azurerm_storage_account" "Storage" {
	name = "tfstorageaccbhuvan"
	resource_group_name	 = data.azurerm_resource_group.rg.name
	location	   	 = data.azurerm_resource_group.rg.location
	account_tier             = "Standard"
  	account_replication_type = "LRS"
  	account_kind             = "StorageV2"

  	tags = {
    		environment = "dev"
  	}
}

resource "azurerm_storage_container" "blob_container" {
  name                  = "tf-blobcontainer-bal"
  storage_account_id  = azurerm_storage_account.Storage.id
  container_access_type = "private"
}

resource "azurerm_storage_share" "file_share" {
  name                 = "tf-fileshare-bal"
  storage_account_id = azurerm_storage_account.Storage.id
  quota                = 100
}

//Email Alert Action Group
resource "azurerm_monitor_action_group" "vm_alert_ag" {
  name                = "vmTF-alert-action-grp-BAL"
  resource_group_name = data.azurerm_resource_group.rg.name
  short_name          = "vmalertTFBAL"

  email_receiver {
    name          = "admin-email"
    email_address = "bhuvan.abc.b12.reports@gmail.com"
  }
}

resource "azurerm_monitor_metric_alert" "vm_cpu_alert" {
  name                = "WinVM-High-CPU-Alert-BAL"
  resource_group_name = data.azurerm_resource_group.rg.name
  scopes              = [azurerm_windows_virtual_machine.WinTFvm-BAL.id]
  description         = "Alert when CPU usage exceeds 50%"
  severity            = 2
  enabled             = true

  frequency   = "PT1M"   # Evaluate every 1 minute
  window_size = "PT5M"   # Over a 5-minute window

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 50
  }

  action {
    action_group_id = azurerm_monitor_action_group.vm_alert_ag.id
  }
}

