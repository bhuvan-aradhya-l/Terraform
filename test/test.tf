data "local_file" "secondfile" {
  filename = "abc123.txt"
}

locals {
  filename = "abc123.txt"
}

variable "filename" {
  default = "abc123.txt"
}

output "filename" {
  value = var.filename
}
