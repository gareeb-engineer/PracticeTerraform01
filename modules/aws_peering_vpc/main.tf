resource "aws_vpc_peering_connection" "Peering" {
  peer_vpc_id = var.firstVpc
  vpc_id      = var.secondVpc
  auto_accept = true

  tags = {
    Name = "Peering"
  }
}