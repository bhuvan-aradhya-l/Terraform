resource "random_pet" "p1" {
  length = 2
}

output "pet_name" {
  value = random_pet.p1.id
}
//---------------------------------------------------------------------
resource "random_integer" "i1" {
  min = 1
  max = 100
}

output "random_number" {
  value = random_integer.i1.result
}
//---------------------------------------------------------------------
resource "random_string" "s1" {
  length  = 8
  special = false
}

locals {
  generated_value = random_string.s1.result
}

output "local_value" {
  value = local.generated_value
}
//---------------------------------------------------------------------
resource "random_pet" "p2" {}

variable "name" {
  default = null
}

locals {
  effective_name = var.name != null ? var.name : random_pet.p2.id
}

output "final_name" {
  value = local.effective_name
}
//---------------------------------------------------------------------
resource "random_password" "pwd" {
  length  = 12
  special = true
}

output "password" {
  value     = random_password.pwd.result
  sensitive = true
}
//---------------------------------------------------------------------
//Multiple Random Values

resource "random_pet" "a1" {}
resource "random_integer" "a2" {
  min = 10
  max = 99
}
resource "random_string" "a3" {
  length = 6
}
resource "random_id" "a4" {
  byte_length = 2
}
resource "random_password" "a5" {
  length = 8
}

output "oa1" {
  value = random_pet.a1.id
}

output "oa2" {
  value = random_integer.a2.result
}

output "oa3" {
  value = random_string.a3.result
}

output "oa4" {
  value = random_id.a4.hex
}

output "oa5" {
  value     = random_password.a5.result
  sensitive = true
}

