provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "Test" {
  ami           = var.ami
  instance_type = var.cpu
  vpc_security_group_ids = ["sg-090fadce25b37b60d"]
  key_name = var.key
  user_data = "${file("u_data.sh")}"

  tags = {
    Name = "Master"
  }
}

output "public_ip" {
  value = "${aws_instance.Test.public_ip}"
}
