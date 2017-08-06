resource "aws_security_group" "docker_swarm_sg" {
  name = "sg_docker_swarm"
  description = "Security group for Docker Swarm"
  vpc_id = "${aws_vpc.docker_swarm_vpc.id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8080
    to_port = 8083
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 2375
    to_port = 2375
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8000
    to_port = 8000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "Docker swarm security group"
    Environment = "production"
    Owner = "DevOps"
  }
}

resource "aws_instance" "docker_swarm_node" {
  ami = "${var.base_ami}"
  instance_type = "t2.large"
  subnet_id = "${aws_subnet.docker_swarm_subnet.id}"
  vpc_security_group_ids  = ["${aws_security_group.docker_swarm_sg.id}"]
  associate_public_ip_address = "true"

  key_name = "${aws_key_pair.docker_swarm_key.key_name}"
  user_data = "${file("./provisioners/install_docker.sh")}"

  root_block_device {
    volume_size = 10
  }

  tags {
    Name = "Docker Swarm Node"
    Environment = "production"
    Owner = "DevOps"
  }
}

output "docker_swarm_node" {
  value = "${aws_instance.docker_swarm_node.public_ip}"
}