//String Datatype
variable "string_val" {
  type    = string
  default = "terraform"
}
//Number Datatype
variable "number_val" {
  type    = number
  default = 8
}
//Boolean Datatype
variable "bool_val" {
  type    = bool
  default = true
}
//List Datatype
variable "list_val" {
  type    = list(string)
  default = ["dev", "stage", "prod"]
}
//Tuple
variable "tuple_val" {
  type    = tuple([string, number, bool])
  default = ["app", 3, true]
}
//Maps
variable "map_val" {
  type = map(string)
  default = {
    env  = "dev"
    team = "platform"
  }
}
//Objects
variable "object_val" {
  type = object({
    name = string
    size = number
  })
  default = {
    name = "service"
    size = 12
  }
}

