module "vpc" {
  source   = "./modules/aws_vpc"
  vpc_cidr = var.vpc_cidr
}
module "vpc_2" {
  source   = "./modules/aws_vpc"
  vpc_cidr = var.vpc2_cidr
}

module "vpc_3" {
  source   = "./modules/aws_vpc"
  vpc_cidr = var.vpc3_cidr
}
###### PEERING CONNECTION ###############################################
module "first_second_peering" {
  source    = "./modules/aws_peering_vpc"
  firstVpc  = module.vpc.vpc_id
  secondVpc = module.vpc_2.vpc_id
}

module "second_third_peering" {
  source    = "./modules/aws_peering_vpc"
  firstVpc  = module.vpc_2.vpc_id
  secondVpc = module.vpc_3.vpc_id
}

module "third_first_peering" {
  source    = "./modules/aws_peering_vpc"
  firstVpc  = module.vpc_3.vpc_id
  secondVpc = module.vpc.vpc_id
}

##SUBNET CREATION

module "subnet" {
  source      = "./modules/aws_subnet"
  vpc_id      = module.vpc.vpc_id
  subnet_cidr = var.subnet_cidr
  zone        = var.zone
}

module "subnet2" {
  source      = "./modules/aws_subnet"
  vpc_id      = module.vpc_2.vpc_id
  subnet_cidr = var.subnet2_cidr
  zone        = var.zone
}

module "subnet3" {
  source      = "./modules/aws_subnet"
  vpc_id      = module.vpc_3.vpc_id
  subnet_cidr = var.subnet3_cidr
  zone        = var.zone
}
### INTERNET GATEWAY CREATION ##############################################
module "igw" {
  source = "./modules/aws_igw"
  vpc_id = module.vpc.vpc_id
}

module "igw2" {
  source = "./modules/aws_igw"
  vpc_id = module.vpc_2.vpc_id
}

module "igw3" {
  source = "./modules/aws_igw"
  vpc_id = module.vpc_3.vpc_id
}
##### NACL CREATION #############################################################
module "nacl" {
  source = "./modules/aws_nacl"
  vpc_id = module.vpc.vpc_id
}

module "nacl2" {
  source = "./modules/aws_nacl"
  vpc_id = module.vpc_2.vpc_id
}

module "nacl3" {
  source = "./modules/aws_nacl"
  vpc_id = module.vpc_3.vpc_id
}

########## SECURITY GROUP #######################################################

module "securityGroup" {
  source = "./modules/aws_securityGroup"
  vpc_id = module.vpc.vpc_id
}

module "securityGroup2" {
  source = "./modules/aws_securityGroup"
  vpc_id = module.vpc_2.vpc_id
}

module "securityGroup3" {
  source = "./modules/aws_securityGroup"
  vpc_id = module.vpc_3.vpc_id
}

######### ROUTE TABLE CREATION ###################################################
module "route_table" {
  source = "./modules/aws_route_table"
  vpc_id = module.vpc.vpc_id
}

module "route_table2" {
  source = "./modules/aws_route_table"
  vpc_id = module.vpc_2.vpc_id
}

module "route_table3" {
  source = "./modules/aws_route_table"
  vpc_id = module.vpc_3.vpc_id
}

######## ROUTE CREATION ##########################################################
resource "aws_route" "connectIGW" {
  route_table_id         = module.route_table.route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = module.igw.igw_id
}

resource "aws_route" "connectIGW2" {
  route_table_id         = module.route_table2.route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = module.igw2.igw_id
}

resource "aws_route" "connectIGW3" {
  route_table_id         = module.route_table3.route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = module.igw3.igw_id
}

resource "aws_route" "vpc_peering_route1" {
  route_table_id            = module.route_table.route_table_id
  destination_cidr_block    = var.vpc2_cidr
  vpc_peering_connection_id = module.first_second_peering.peeing_id
}

resource "aws_route" "vpc_peering_route2" {
  route_table_id            = module.route_table.route_table_id
  destination_cidr_block    = var.vpc3_cidr
  vpc_peering_connection_id = module.third_first_peering.peeing_id
}

resource "aws_route" "vpc2_peering_route1" {
  route_table_id            = module.route_table2.route_table_id
  destination_cidr_block    = var.vpc_cidr
  vpc_peering_connection_id = module.first_second_peering.peeing_id
}

resource "aws_route" "vpc2_peering_route2" {
  route_table_id            = module.route_table2.route_table_id
  destination_cidr_block    = var.vpc3_cidr
  vpc_peering_connection_id = module.second_third_peering.peeing_id
}

resource "aws_route" "vpc3_peering_route1" {
  route_table_id            = module.route_table3.route_table_id
  destination_cidr_block    = var.vpc_cidr
  vpc_peering_connection_id = module.third_first_peering.peeing_id
}

resource "aws_route" "vpc3_peering_route2" {
  route_table_id            = module.route_table3.route_table_id
  destination_cidr_block    = var.vpc2_cidr
  vpc_peering_connection_id = module.second_third_peering.peeing_id
}


####### ROUTE ASSOCIATION ########################################################
resource "aws_route_table_association" "attachToSubnet" {
  subnet_id      = module.subnet.subnet_id
  route_table_id = module.route_table.route_table_id
}

resource "aws_route_table_association" "attachToSubnet2" {
  subnet_id      = module.subnet2.subnet_id
  route_table_id = module.route_table2.route_table_id
}

resource "aws_route_table_association" "attachToSubnet3" {
  subnet_id      = module.subnet3.subnet_id
  route_table_id = module.route_table3.route_table_id
}

####### NACL ASSOCATION ##########################################################
resource "aws_network_acl_association" "VPCAssociationNACL" {
  network_acl_id = module.nacl.nacl_id
  subnet_id      = module.subnet.subnet_id
}

resource "aws_network_acl_association" "VPCAssociationNACL2" {
  network_acl_id = module.nacl2.nacl_id
  subnet_id      = module.subnet2.subnet_id
}

resource "aws_network_acl_association" "VPCAssociationNACL3" {
  network_acl_id = module.nacl3.nacl_id
  subnet_id      = module.subnet3.subnet_id
}

###### EC2 CREATION ##############################################################
module "instance" {
  source          = "./modules/aws_instance"
  subnet_id       = module.subnet.subnet_id
  security_groups = module.securityGroup.sg_id
}

module "instance2" {
  source          = "./modules/aws_instance"
  subnet_id       = module.subnet2.subnet_id
  security_groups = module.securityGroup2.sg_id
}

module "instance3" {
  source          = "./modules/aws_instance"
  subnet_id       = module.subnet3.subnet_id
  security_groups = module.securityGroup3.sg_id
}
