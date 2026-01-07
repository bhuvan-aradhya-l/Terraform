resource "local_file" "f1" {
  filename = var.filename1
  content  = var.content
}

resource "local_file" "f2" {
  filename = var.filename2
  content  = var.content
}

resource "local_file" "f3" {
  filename = var.filename2
  content  = var.content
}

resource "local_file" "f4" {
  filename = var.filename4
  content  = var.content
}
resource "local_file" "f5" {
  filename = var.filename5[2]
  content  = var.content
}

resource "local_file" "f6" {
  filename = var.filename6[1]
  content  = var.content
}

variable filename6 {
	default = ["1","2","3",4,5,6]
	type = list(number)
}
