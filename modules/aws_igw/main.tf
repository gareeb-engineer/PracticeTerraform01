resource "aws_internet_gateway" "internetgatewayFirstVPC" {
  vpc_id = var.vpc_id
  tags = var.igw_tags
}

