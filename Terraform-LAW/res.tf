//To read existing Resource Group
data "azurerm_resource_group" "rg" {
	name = "az-tf-BAL"
}

# --- 2. APPLY TAGS (Using Azure CLI via Terraform) ---
# This runs "az tag update" on your machine to tag the resources in the cloud.

resource "null_resource" "tag_rg" {
  # Triggers ensure this runs if the RG ID changes
  triggers = {
    rg_id = data.azurerm_resource_group.rg.id
  }

  provisioner "local-exec" {
    command = <<EOT
      az tag update --resource-id ${data.azurerm_resource_group.rg.id} \
      --operation Merge \
      --tags Environment=Production Owner=DevOps-Team Project=Scenario14-Compliance
    EOT
  }
}

//To create Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "law" {
  name                = "law-BAL-CK"
  location            = "Northeurope"
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

//To Create Data Collection Rule (DCR)
resource "azurerm_monitor_data_collection_rule" "dcr" {
  name                = "dcr-BAL-CK"
  resource_group_name = data.azurerm_resource_group.rg.name
  location = azurerm_log_analytics_workspace.law.location

  destinations {
    log_analytics {
      workspace_resource_id = azurerm_log_analytics_workspace.law.id
      name                  = "law-BAL-CK"
    }
  }

  data_sources {
    syslog {
	streams        = ["Microsoft-Syslog"]
        name           = "syslog"
	facility_names = ["auth", "authpriv", "cron", "daemon", "mark", "kern", "syslog", "user", "uucp"]
      	log_levels     = ["Debug", "Info", "Notice", "Warning", "Error", "Critical", "Alert", "Emergency"]
    }
  }

  data_flow {
    streams      = ["Microsoft-Syslog"]
    destinations = ["law-BAL-CK"]
  }
}

//To read the existing VM
data "azurerm_virtual_machine" "linVM" {
	name = "vm-tf-BAL"
	resource_group_name = data.azurerm_resource_group.rg.name
}

resource "null_resource" "tag_vm" {
  triggers = {
    vm_id = data.azurerm_virtual_machine.linVM.id
  }

  provisioner "local-exec" {
    command = <<EOT
      az tag update --resource-id ${data.azurerm_virtual_machine.linVM.id} \
      --operation Merge \
      --tags Environment=Production Owner=DevOps-Team Project=Scenario14-Compliance
    EOT
  }
}

//To Attach DCR to VM
resource "azurerm_monitor_data_collection_rule_association" "vm_dcr" {
  name                    = "vm-dcr-association-BAL-CK"
  target_resource_id      = data.azurerm_virtual_machine.linVM.id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.dcr.id
}

resource "azurerm_virtual_machine_extension" "ama" {
  name                 = "AzureMonitorLinuxAgent"
  virtual_machine_id   = data.azurerm_virtual_machine.linVM.id
  publisher            = "Microsoft.Azure.Monitor"
  type                 = "AzureMonitorLinuxAgent"
  type_handler_version = "1.0"
  auto_upgrade_minor_version = true
}
