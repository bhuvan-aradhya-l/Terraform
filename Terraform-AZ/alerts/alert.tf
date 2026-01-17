resource "azurerm_monitor_metric_alert" "winvm_cpu_high" {
  name                = "WinVM-CPU-Above-60"
  resource_group_name = "cligroup1-BAL"
  scopes              = [var.winvm_id]
  description         = "Alert when Windows VM CPU usage is above 60%"
  severity            = 2
  enabled             = true
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 60
  }

  action {
    action_group_id = azurerm_monitor_action_group.cpu_alert_ag.id
  }
}

