resource "local_file" "firstfile" {
  filename = "abc.txt"
  content  = "This is my third file created from terraform"
}

resource "local_file" "firstfile1" {
  filename          = "a/b/abc1.txt"
  sensitive_content = "This is my third file created from terraform with Base 64 encoding"
}

resource "local_file" "firstfile2" {
  filename       = "a/abc_base64.txt"
  content_base64 = "VGhpcyBpcyBhIGZpbGUgY3JlYXRlZCBmcm9tIHRlcnJhZm9ybSB3aXRoIEJhc2UgNjQgZW5jb2Rpbmcu"
}
