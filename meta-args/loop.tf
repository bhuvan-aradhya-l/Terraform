//count
resource "local_file" "f11" {
  count    = length(var.filename)
  filename = var.filename[count.index]
  content  = "aaa"
}
variable "filename" {
  type    = list(string)
  default = ["abc.txt", "xyz.txt"]
}

//for_each
resource "local_file" "f12" {
  filename = each.value
  for_each = var.filename1
  content  = "aaa"
}

variable "filename1" {
  type    = set(string)
  default = ["abcd.txt", "xyzd.txt"]
}

//count method on map datatype
resource "local_file" "f13" {
	count = length(keys(var.filename2))
	filename = values(var.filename2)[count.index]
	content = "Content in f13"
}
variable "filename2" {
	type = map(string)
	default = {
		file1 = "abc.txt"
		file2 = "xyz.txt"
	}
}

//for_each method for map datatype
resource "local_file" "f14" {
	filename = each.value
	for_each = var.filename3
	content = "Content in f14"
}
variable "filename3" {
	type = map(string)
	default = {
	abc = "abc.txt"
	xyz = "xyz.txt"
	}
}
