terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "3.110.0"
    }
  }
}

provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    //resource_group_name  = "rg-BAL"
    //storage_account_name = "bhuvanstrgacc123"
    //container_name       = "adocontainer"
    //key                  = "storagestate.tfstate"
  }
}