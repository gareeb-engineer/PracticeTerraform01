resource "aws_instance" "FirstVPCEc2" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_groups
  key_name               = "balapem"
  tags = var.instance_tags
}