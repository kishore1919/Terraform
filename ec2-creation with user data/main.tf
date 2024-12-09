terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.4.0"
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "Test" {
  ami           = var.ami
  instance_type = var.cpu
  vpc_security_group_ids = [var.sg]
  key_name = var.key
  user_data = "${file("u_data.sh")}"

  tags = {
    Name = "Master"
  }
}

output "public_ip" {
  value = "${aws_instance.Test.public_ip}"
}
