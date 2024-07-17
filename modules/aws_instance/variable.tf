variable "instance_ami" {
  type = string
  default = "ami-0607784b46cbe5816"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "subnet_id" {
  type = string
}

variable "security_groups" {
  type = list(any)
}

variable "instance_tags" {
  type = map(any)
  default = {
    "Name" = "MyEC2"
  }
}