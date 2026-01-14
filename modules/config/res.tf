resource "local_file" "f1" {
	filename = var.f1
	content = var.c1
}
variable f1{
	default="ABC"
}
variable c1{
	default="Content"
}

output o1{
	value=local_file.f1.id
}
