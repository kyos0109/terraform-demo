provider "aws" {}

# get availability zones info
module "availability_zones" {
  source = "./modules/availability_zones"
}

# create vpc
module "vpc" {
  source     = "./modules/vpc"
  cidr_block = var.vpc_cidr_block
  tags       = var.demo_tags
  tag_name   = var.vpc_tag_name
}

# create public subnets
module "public_subnets" {
  source                  = "./modules/public_subnets"
  vpc_id                  = module.vpc.this.id
  cidr_block_default      = module.vpc.this.cidr_block
  availability_zone_names = module.availability_zones.names
  availability_zone_list  = module.availability_zones.list
  subnet_newbits          = var.subnet_newbits
  tag_name_prefix         = var.public_subnet_name_prefix
  tags                    = var.demo_tags
}

# create private subnet
module "private_subnets" {
  source                  = "./modules/private_subnets"
  vpc_id                  = module.vpc.this.id
  availability_zone_names = module.availability_zones.names
  availability_zone_list  = module.availability_zones.list
  subnet_newbits          = var.subnet_newbits
  cidr_block_default      = module.vpc.this.cidr_block
  subnet_ids              = module.public_subnets.ids
  tag_name_prefix         = var.private_subnet_name_prefix
  tags                    = var.demo_tags
}

# create protection subnet
module "protection_subnets" {
  source                  = "./modules/protection_subnets"
  vpc_id                  = module.vpc.this.id
  availability_zone_names = module.availability_zones.names
  availability_zone_list  = module.availability_zones.list
  subnet_newbits          = var.subnet_newbits
  cidr_block_default      = module.vpc.this.cidr_block
  subnet_ids              = concat(module.public_subnets.ids, module.private_subnets.ids)
  tag_name_prefix         = var.protection_subnet_name_prefix
  tags                    = var.demo_tags
}

# create protection subnet default acl
module "protection_network_default_acl" {
  source                 = "./modules/protection_network_acl"
  vpc_id                 = module.vpc.this.id
  protection_subnet_ids  = module.protection_subnets.ids
  protection_subnet_this = module.protection_subnets.this
  private_subnets_this   = module.private_subnets.this
  trust_list_acl         = var.trust_list_acl
  tags                   = var.demo_tags
}

# get ssh jumper image
module "jumper_host_image" {
  source = "./modules/ec2_image"

  owners      = ["amazon"]
  filter_name = ["amzn2-ami-hvm-*-x86_64-gp2"]
}

# create ami policy and profile
module "ec2ssm" {
  source = "./modules/iam_role"

  name        = "AllowEC2SSM"
  description = "happy"
  tags        = var.demo_tags
}

# create ssh key
module "happy_ssh_key" {
  source              = "./modules/ssh_key_pair"
  key_name            = "happyKey"
  ssh_public_key_path = var.ssh_public_key_path
  ssh_public_key_name = var.ssh_public_key_name
}

# create ssh jumper
module "jumper_hosts" {
  source              = "./modules/ec2_instance"
  tag_name            = var.jumper_tag_name
  ssh_jumper_count    = length(module.availability_zones.list)
  ec2_instance_map    = var.ec2_instance_map
  image_id            = module.jumper_host_image.image_id
  ssh_key_name        = module.happy_ssh_key.id
  subnet_ids          = module.public_subnets.ids
  security_groups_ids = [module.demo_security_group.this.id]
  # instance_profile    = module.ec2ssm.ssm_instance_profile
  description         = "ssh jumper"
  tags                = var.demo_tags
}

# create demo security group
module "demo_security_group" {
  source = "./modules/security_group"

  name        = "allow-demo"
  description = "Allow Demo happy"
  vpc_id      = module.vpc.this.id
  tags        = var.demo_tags
}

# add sg rule tcp 80
resource "aws_security_group_rule" "allow_http" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = module.demo_security_group.this.id
}

# add sg rule tcp 22
resource "aws_security_group_rule" "allow_ssh" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = module.demo_security_group.this.id
}

# create NAT Gateway EIP
module "nat_gw_eip" {
  source = "./modules/eip"

  eip_count              = length(module.availability_zones.list)
  availability_zone_list = module.availability_zones.name_suffix
  eip_perfix_name        = var.nat_gw_eip_perfix_name
  tags                   = var.demo_tags
}

# create jumper EIP
module "jumper_eip" {
  source = "./modules/eip"

  eip_count              = length(module.availability_zones.list)
  availability_zone_list = module.availability_zones.name_suffix
  eip_perfix_name        = var.jumper_tag_name
  tags                   = var.demo_tags
  instance_ids           = module.jumper_hosts.id
}

# create NAT Gateway
resource "aws_nat_gateway" "nat_gw" {
  count         = length(module.private_subnets.ids)
  allocation_id = element(module.nat_gw_eip.this.*.id, count.index)
  subnet_id     = module.private_subnets.ids[count.index]

  tags = {
    Name     = format("%s-%s", "nat-gw", element(module.availability_zones.name_suffix, count.index)),
    CreateAt = timestamp(),
    Demo     = "happy"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

# create private subnet route default nat-gw
resource "aws_route_table" "private_route_table" {
  count  = length(module.private_subnets.ids)
  vpc_id = module.vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = element(aws_nat_gateway.nat_gw.*.id, count.index)
  }

  tags = {
    Name     = format("%s-%s-%s", "nat-rtb", var.private_subnet_name_prefix, element(module.availability_zones.name_suffix, count.index)),
    CreateAt = timestamp(),
    Demo     = "happy"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

# create private subnet route association
resource "aws_route_table_association" "private_route_association" {
  count          = length(module.private_subnets.ids)
  subnet_id      = element(module.private_subnets.this.*.id, count.index)
  route_table_id = element(aws_route_table.private_route_table.*.id, count.index)
}

