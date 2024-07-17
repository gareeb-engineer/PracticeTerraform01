variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "vpc2_cidr" {
  default = "192.168.0.0/16"
}

variable "vpc3_cidr" {
  default = "172.16.0.0/16"
}

variable "subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "subnet2_cidr" {
  default = "192.168.1.0/24"
}

variable "subnet3_cidr" {
  default = "172.16.1.0/24"
}

variable "subnet_is_public" {
  default = true
}

variable "zone" {
  type    = string
  default = "ap-south-1a"
}