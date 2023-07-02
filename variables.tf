variable "env" {
  description = "Specify environment"
  type        = string
  nullable    = false
}

variable "ec2_ami_id" {
  description = "Specify AWS AMI id for the instnces"
  type        = string
  nullable    = false
  default     = ""
}


variable "ec2_instance_type" {
  description = "AWS instance type"
  type        = string
  nullable    = false
}

variable "ec2_hostname" {
  description = "Instance hostname"
  type        = string
  nullable    = false
}

variable "ec2_key_name" {
  description = "Key name of the Key Pair to use for the instance"
  type        = string
  nullable    = false
  default     = ""
}

variable "ec2_vpc_security_group_ids" {
  description = "List of security group IDs to associate with"
  type        = list(string)
  nullable    = false
}

variable "ec2_subnet_id" {
  description = "VPC Subnet ID to launch in"
  type        = string
  nullable    = false
}

variable "ec2_monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  type        = bool
  nullable    = false
  default     = false
}
