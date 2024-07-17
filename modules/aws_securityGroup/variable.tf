variable "vpc_id" {
  type = string
}

variable "sg_tags" {
  type = map(any)
  default = {
    "Name" = "MySG"
  }
}