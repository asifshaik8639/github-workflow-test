terraform {
  backend "s3" {
    bucket         = "demo-trf-state-asif"
    key            = "server/test/terraform.tfstate"
    region         = "ap-south-1"
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "nginx" {
  ami = "ami-06f77c258427de42c"
  instance_type = "t2.micro"

  tags = {
   Name = "nginx-server"
  }

  security_groups = [
    aws_security_group.example.name
  ]
}

resource "aws_security_group" "example" {
  name        = "example-security-group"
  description = "Example Security Group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

