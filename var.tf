//Variable Initialization
variable "content" {
  type    = any
  default = "common content"
}

variable "filename1" {
  default = true
  type    = string
}

variable "filename2" {
  default = true
  type    = bool
}

variable "filename3" {
  default = 123
  type    = number
}

variable "filename4" {
  default = 69556
  type    = number
}
variable "filename5" {
  default = ["123", "owirg", true]
  type    = list(any)
}
