resource "aws_route_table" "FirstVPCTable" {
  vpc_id = var.vpc_id
  tags = var.route_tags
}

