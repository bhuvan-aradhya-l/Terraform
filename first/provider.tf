terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "<=2.5.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.4"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }
}
