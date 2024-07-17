variable "vpc_id" {
  type = string
}

variable "subnet_cidr" {
  type = string
  default = "10.0.1.0/24"
}

variable "subnet_tag" {
  type = map(any)
  default = {
    "Name" = "MySubnet"
  }
}

variable "subnet_is_public" {
  type = bool
  default = true
}

variable "zone" {
  type = string
}