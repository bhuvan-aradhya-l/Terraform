variable "filename7" {
  default = [1234, 456, 789, 1234, 4, 456]
  type    = set(number)
}
variable "filename8" {
  type = map(any)
  default = {
    name     = "adi"
    phnum    = 45612315
    isactive = true
  }
}
variable "filename9" {
  type = map(list(any))
  default = {
    name     = ["adi", "karthik"]
    phnum    = [45612315, 23564]
    isactive = [true, false]
  }
}


variable "filename10" {
  type    = tuple([string, number, list(number)])
  default = ["dghsvd", 1132, [1, 2.3, 5]]
}

variable "filename11" {
  type = object({
    name    = string
    id      = number
    address = list(string)
  })
  default = {
    name    = "adi"
    id      = 876
    address = ["marathalli", "bangalore"]
  }
}
