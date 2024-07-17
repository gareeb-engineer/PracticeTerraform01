variable "vpc_id" {
  type = string
}

variable "nacl_tags" {
  type = map(any)
  default = {
    "Name" = "mynacl"
  }
}