#EC2 security group
resource "aws_security_group" "website_allow_ssh" {
  vpc_id = "${aws_vpc.ecs.id}"
  name = "allow_ssh"
  description = "security group that allows ssh and all egress traffic"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    terraform = "true"
    Name      = "allow ssh"
  }
}

## Security Group for ELB
resource "aws_security_group" "elb" {
  vpc_id = "${aws_vpc.ecs.id}"
  name = "terraform-example-elb"
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    terraform = "true"
    Name      = "allow all traffi"
  }
}