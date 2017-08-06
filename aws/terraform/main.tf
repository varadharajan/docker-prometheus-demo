provider "aws" {
}

variable "vpc_cidr" {
  type = "string"
  description = "CIDR for VPC"
}

variable "docker_swarm_subnet_cidr" {
  type = "string"
  description = "CIDR for CI subnet"
}

variable "base_ami" {
  type = "string"
  description = "Base Ubuntu AMI"
}
