variable "content" {
  type    = any
  default = "common content"
}
resource "local_file" "f9" {
  filename = var.filename8.phnum
  content  = var.content
}

resource "local_file" "f10" {
  filename = var.filename9.phnum[1]
  content  = var.content
}

resource "local_file" "f11" {
  filename = var.filename10[0]
  content  = var.content
}

resource "local_file" "f12" {
  filename = var.filename11.address[0]
  content  = var.content
}
