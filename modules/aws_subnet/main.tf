resource "aws_subnet" "FirstVPCSubnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.subnet_cidr
  map_public_ip_on_launch = var.subnet_is_public
  availability_zone = var.zone
  tags = var.subnet_tag
}

