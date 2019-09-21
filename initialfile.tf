terraform {
  required_version = ">= 0.12.0"
}
​
provider "aws" {
  region = "eu-west-1"
}
​
locals {
  website_userdata = <<EOF
#!/bin/bash
sudo apt update
sudo apt install -y nginx
curl https://pastebin.com/raw/UPuZCtsx | sudo tee /var/www/html/index.html
  EOF
}
​
resource "aws_key_pair" "brett" {
  key_name   = "brett-key"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}
​
resource "aws_security_group" "website" {
  name = "website"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
​
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
​
resource "aws_instance" "web" {
  ami             = "ami-0713a3840a5ddccbe"
  instance_type   = "t2.micro"
  key_name        = "${aws_key_pair.brett.key_name}"
  user_data       = "${local.website_userdata}"
  security_groups = ["${aws_security_group.website.name}"]
​
  tags = {
    Name = "My Webserver"
  }
}
