resource "aws_security_group" "FirstVPCSG" {
  vpc_id = var.vpc_id
  ingress {
    description      = "Allow ssh"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = var.sg_tags
}