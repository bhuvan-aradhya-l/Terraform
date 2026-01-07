data local_file readfile {
	filename="/home/bhuvan/Desktop/ABC/gitClass5.txt"
}

output filecontent{
	value=data.local_file.readfile.content_base64
}

resource "local_file" "f1" {
                  filename = "a.prop"
                  content  = data.local_file.readfile.content_base64
                }
