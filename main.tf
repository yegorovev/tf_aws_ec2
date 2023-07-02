data "aws_key_pair" "kp" {
  filter {
    name   = "tag:ec2"
    values = [var.ec2_hostname]
  }
  filter {
    name   = "tag:ENV"
    values = [var.ENV]
  }
}

data "aws_ami" "ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-kernel-6.1-x86_64"]
  }
}

resource "aws_instance" "this" {
  ami                    = try(var.ec2_ami_id, data.aws_ami.ami.id)
  instance_type          = var.ec2_instance_type
  key_name               = try(var.ec2_key_name, data.aws_key_pair.kp.key_name)
  vpc_security_group_ids = var.ec2_vpc_security_group_ids
  subnet_id              = var.ec2_subnet_id
  monitoring             = var.ec2_monitoring
  tags = {
    Name = var.ec2_hostname
  }
}
