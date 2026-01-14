locals {
  filename_upper      = [for key, value in var.filenamemap : upper(value)]
  filename_upper_list = [for value in var.filenamelist : upper(value)]
  map_upper           = { for key, value in var.filenamemap : upper(key) => lower(value) }
}

output "mapupper" {
  value = local.map_upper
}
output "listupper" {
  value = local.filename_upper_list
}
resource "local_file" "f1" {
  count    = length(local.filename_upper)
  filename = local.filename_upper[count.index]
  content  = "test"
}
variable "filenamemap" {
  type = map(string)
  default = {
    name  = "a"
    name2 = "b"
  }
}
variable "filenamelist" {
  type    = list(string)
  default = ["a", "b"]
}
