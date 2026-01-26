//resource group variables
variable "location" {
  default = "AustraliaEast"
  type    = string
}

variable "rg_name" {
  default = "cligroup1-BAL"
  type    = string
}

//vnet variables
variable "address_space" {
  default = ["10.0.0.0/16"]
  type    = list(string)
}

variable "vnet_name" {
  default = "tf_vnet_BAL"
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
      name             = "tf_subnet_BAL"
      address_prefixes = ["10.0.1.0/24"]
    },
    {
      name             = "tf_subnet2_BAL"
      address_prefixes = ["10.0.2.0/24"]
    }
  ]
}

