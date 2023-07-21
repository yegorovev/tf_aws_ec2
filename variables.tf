# Network state
variable "net_remote_state_region" {
  description = "Region for network remote state"
  type        = string
  nullable    = false
}

variable "net_backet_remote_state" {
  description = "Bucket name for network remote state"
  type        = string
  nullable    = false
}

variable "net_key_remote_state" {
  description = "Key name for network remote state"
  type        = string
  nullable    = false
}

# EC2
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

variable "ec2_default_ami" {
  description = "Default ami for EC2 instance"
  type        = string
  nullable    = false
  default     = ""
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

variable "ec2_vpc_security_groups" {
  description = "List of security group names to associate with"
  type        = list(string)
  nullable    = false
}

variable "ec2_subnet_name" {
  description = "VPC Subnet name to launch in"
  type        = string
  nullable    = false
}

variable "ec2_monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  type        = bool
  nullable    = false
  default     = false
}

variable "ec2_source_dest_check" {
  description = "Controls if traffic is routed to the instance when the destination address does not match the instance. (NAT or VPNs)"
  type        = bool
  nullable    = false
  default     = true
}
