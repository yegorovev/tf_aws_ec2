data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = var.net_backet_remote_state
    key    = var.net_key_remote_state
    region = var.net_remote_state_region
  }
}

data "aws_key_pair" "kp" {
  count = var.ec2_key_name == "" ? 1 : 0

  filter {
    name   = "tag:ec2"
    values = [var.ec2_hostname]
  }
  filter {
    name   = "tag:ENV"
    values = [var.env]
  }
}

data "aws_ami" "ami" {
  count = var.ec2_ami_id == "" ? 1 : 0

  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = [var.ec2_default_ami]
  }
}

locals {
  ec2_subnet_id = matchkeys(data.terraform_remote_state.network.outputs.subnets[*].subnets.id,
    data.terraform_remote_state.network.outputs.subnets[*].subnets.tags.Name,
  [var.ec2_subnet_name])[0]

  ec2_vpc_security_group_ids = matchkeys(data.terraform_remote_state.network.outputs.security_groups[*].sg.id,
    data.terraform_remote_state.network.outputs.security_groups[*].sg.name,
  var.ec2_vpc_security_groups)
}

resource "aws_instance" "this" {
  ami                    = var.ec2_ami_id != "" ? var.ec2_ami_id : data.aws_ami.ami[0].id
  instance_type          = var.ec2_instance_type
  key_name               = var.ec2_key_name != "" ? var.ec2_key_name : data.aws_key_pair.kp[0].key_name
  vpc_security_group_ids = local.ec2_vpc_security_group_ids
  subnet_id              = local.ec2_subnet_id
  monitoring             = var.ec2_monitoring
  source_dest_check      = var.ec2_source_dest_check
  tags = {
    Name = var.ec2_hostname
  }
}

# Route
module "route" {
  source = "git@github.com:yegorovev/tf_aws_route.git?ref=v1.0.1"
  count  = var.rt_name != null ? 1 : 0

  vpc_id                 = data.terraform_remote_state.network.outputs.vpc.vpc.id
  rt_name                = var.rt_name
  igw_name               = null
  destination_cidr_block = var.destination_cidr_block
  network_interface_id   = aws_instance.this.primary_network_interface_id

  depends_on = [
    aws_instance.this
  ]
}
