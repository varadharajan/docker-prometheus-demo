# Provision VPC and subnets
resource "aws_vpc" "docker_swarm_vpc" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "Docker swarm VPC"
    Environment = "production"
    Owner = "DevOps"
  }
}

resource "aws_internet_gateway" "docker_swarm_vpc_ig" {
  vpc_id = "${aws_vpc.docker_swarm_vpc.id}"

  tags {
    Name = "Docker swarm Internet Gateway"
    Environment = "production"
    Owner = "DevOps"
  }
}

resource "aws_subnet" "docker_swarm_subnet" {
  vpc_id = "${aws_vpc.docker_swarm_vpc.id}"
  cidr_block = "${var.docker_swarm_subnet_cidr}"
  map_public_ip_on_launch = false

  tags {
    Name = "Docker swarm Subnet"
    Environment = "production"
    Owner = "DevOps"
  }
}

resource "aws_route_table" "docker_swarm_subnet_route_table" {
  vpc_id = "${aws_vpc.docker_swarm_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.docker_swarm_vpc_ig.id}"
  }

  tags {
    Name = "Docker Swarm Subnet Route Table"
    Environment = "production"
    Owner = "DevOps"
  }
}

resource "aws_route_table_association" "docker_swarm_route_table_association" {
  subnet_id = "${aws_subnet.docker_swarm_subnet.id}"
  route_table_id = "${aws_route_table.docker_swarm_subnet_route_table.id}"
}
