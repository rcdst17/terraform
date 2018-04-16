terraform {
  required_version = "> 0.7.0"
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_security_group" "demo" {
  name = "demo"
  tags {
        Name = "SSH"
  }
  description = "ONLY ssh CONNECTION INBOUND"
  ingress {
      from_port   = "22"
      to_port     = "22"
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "demo" {
    ami = "ami-1853ac65" 
    instance_type = "t2.micro"
    key_name = "aws_ec2_demo_key"
    vpc_security_group_ids = ["${aws_security_group.demo.id}"]
}