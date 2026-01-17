variable "winvm_id" {
  default = "/subscriptions/53d10f2d-7d56-4d45-a103-34e5a1bce523/resourceGroups/cligroup1-BAL/providers/Microsoft.Compute/virtualMachines/WinVM-BAL"
}
resource "azurerm_monitor_action_group" "cpu_alert_ag" {
  name                = "winvm-cpu-action-group-BAL"
  resource_group_name = var.rg_name
  short_name          = "cpualert"

  email_receiver {
    name          = "email-alert"
    email_address = "bhuvan.abc.b12.reports@gmail.com"
  }
}


variable "rg_name" {
  default = "cligroup1-BAL"
}
