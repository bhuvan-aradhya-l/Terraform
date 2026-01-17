data "azurerm_virtual_machine" "vmtfBAL" {
  name                = "vm-tf-BAL"
  resource_group_name = "az-tf-BAL"
}

resource "azurerm_image" "vmImageBAL" {
  name                      = "vm-tf-Image-BAL"
  location                  = data.azurerm_virtual_machine.vmtfBAL.location
  resource_group_name       = data.azurerm_virtual_machine.vmtfBAL.resource_group_name
  source_virtual_machine_id = data.azurerm_virtual_machine.vmtfBAL.id
}
