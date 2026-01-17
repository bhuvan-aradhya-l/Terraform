//resource group variables
variable "location" {
  default = "Northeurope"
  type    = string
}

variable "rg_name" {
  default = "az-tf-BAL"
  type    = string
}

//vnet variables
variable "address_space" {
  default = ["172.0.0.0/16"]
  type    = list(string)
}

variable "vnet_name" {
  default = "az_tf_vnet_BAL"
  type    = string
}

//subnet variables
//variable address_prefixes {
//	default = ["10.0.1.0/24"]
//	type = list(string)
//}
//variable subnet_name {
//	default = "tf_subnet"
//	type = string
//}

//Multiple subnet creation
variable "address_prefix" {
  type = list(object({
    name             = string
    address_prefixes = list(string)
  }))
  default = [
    {
      name             = "az_tf_subnet_BAL"
      address_prefixes = ["172.0.1.0/24"]
    },
    {
      name             = "az_tf_subnet2_BAL"
      address_prefixes = ["172.0.2.0/24"]
    }
  ]
}

