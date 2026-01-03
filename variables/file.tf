resource "local_file" "f1" {
  filename = local.filename
  content  = local.content
}

resource "local_file" "f2" {
  filename = var.filename
  content  = var.content
}
