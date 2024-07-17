resource "aws_vpc" "vpc_First" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = var.vpc_tag
}

