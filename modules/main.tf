//module definition
module "m1" {
  source = "./config"
  f1     = var.m1f1
  c1     = "m1c1"
}
module "m2" {
  source = "./config"
  f1     = "m2f1"
  c1     = "m2c1"
}
output m1f1 {
	value = module.m1.o1
}
variable "m1f1" {
  default = "m1f1"
}
module "vnet_example_all_default" {
  source  = "Azure/vnet/azurerm//examples/all_default"
  version = "5.0.1"
}
