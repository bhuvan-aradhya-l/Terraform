//Random String (string + number + bool)
resource "random_string" "example" {
  length  = var.number_val
  upper   = var.bool_val
  lower   = true
  numeric = true
  special = false

  keepers = {
    base = var.string_val
  }
}

//List → random_shuffle
resource "random_shuffle" "envs" {
  input        = var.list_val
  result_count = 2
}

//Tuple → random_integer
resource "random_integer" "tuple_based" {
  min = var.tuple_val[1]
  max = var.tuple_val[1] + 10
}

//Map → keepers
resource "random_id" "map_example" {
  byte_length = 4

  keepers = {
    env  = var.map_val["env"]
    team = var.map_val["team"]
  }
}

//Object → random_password
resource "random_password" "object_example" {
  length  = var.object_val.size
  special = false

  keepers = {
    name = var.object_val.name
  }
}
