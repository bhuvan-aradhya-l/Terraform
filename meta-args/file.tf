//implicit/direct dependencies
resource "local_file" "f1" {
  filename = "abc_modified"
  content  = local_file.f3.id
}

resource "local_file" "f2" {
  filename = "xyz"
  content  = local_file.f1.id
}

//explicit/indirect dependencies
resource "local_file" "f3" {
  filename = "abcd"
  content  = "content in file 3"
}

resource "local_file" "f4" {
  filename   = "xyz2"
  content    = "content in file 4"
  depends_on = [local_file.f3, local_file.f2]
  lifecycle {
    create_before_destroy = true
  }

}

resource "local_file" "f5" {
  filename = "newfile5_modified"
  content  = "content in file 5_modified"
}
