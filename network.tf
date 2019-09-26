variable "vpc_netmask" {
  type    = string
  default = "10.254.128.0/17"
}

resource "aws_vpc" "ecs" {
  cidr_block                       = var.vpc_netmask
  assign_generated_ipv6_cidr_block = true

  tags        = {
    terraform = "true"
    Name      = "ecs_VPC"
  }
}

resource "aws_internet_gateway" "ecs_gw" {
  vpc_id = aws_vpc.ecs.id

  tags        = {
    terraform = "true"
    Name      = "ecs gw"
  }
}

data "aws_vpc" "ecs" {
  id = aws_vpc.ecs.id
}

# Assumes there are 3 availability zones minimum
resource "aws_subnet" "ecs_subnet_a" {
  vpc_id            = aws_vpc.ecs.id
  availability_zone = data.aws_availability_zones.available.names[0]
  cidr_block        = cidrsubnet(aws_vpc.ecs.cidr_block, 6, 0)
  ipv6_cidr_block   = cidrsubnet(aws_vpc.ecs.ipv6_cidr_block, 8, 0)

  tags = {
    Name      = "${data.aws_vpc.ecs.tags["Name"]} AZ ${data.aws_availability_zones.available.names[0]}"
    terraform = "true"
  }
}

resource "aws_subnet" "ecs_subnet_b" {
  vpc_id            = aws_vpc.ecs.id
  availability_zone = data.aws_availability_zones.available.names[1]
  cidr_block        = cidrsubnet(aws_vpc.ecs.cidr_block, 6, 1)
  ipv6_cidr_block   = cidrsubnet(aws_vpc.ecs.ipv6_cidr_block, 8, 1)

  tags = {
    Name      = "${data.aws_vpc.ecs.tags["Name"]} AZ ${data.aws_availability_zones.available.names[1]}"
    terraform = "true"
  }
}

resource "aws_subnet" "ecs_subnet_c" {
  vpc_id            = aws_vpc.ecs.id
  availability_zone = data.aws_availability_zones.available.names[2]
  cidr_block        = cidrsubnet(aws_vpc.ecs.cidr_block, 6, 2)
  ipv6_cidr_block   = cidrsubnet(aws_vpc.ecs.ipv6_cidr_block, 8, 2)

  tags = {
    Name      = "${data.aws_vpc.ecs.tags["Name"]} AZ ${data.aws_availability_zones.available.names[2]}"
    terraform = "true"
  }
}

resource "aws_route_table" "ecs_route_table" {
  vpc_id = aws_vpc.ecs.id

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.ecs_gw.id
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ecs_gw.id
  }

  tags = {
    terraform = "true"
    Name      = "ecs route table"
  }
}

resource "aws_route_table_association" "subnet_a" {
  subnet_id      = aws_subnet.ecs_subnet_a.id
  route_table_id = aws_route_table.ecs_route_table.id
}

resource "aws_route_table_association" "subnet_b" {
  subnet_id      = aws_subnet.ecs_subnet_b.id
  route_table_id = aws_route_table.ecs_route_table.id
}

resource "aws_route_table_association" "subnet_c" {
  subnet_id      = aws_subnet.ecs_subnet_c.id
  route_table_id = aws_route_table.ecs_route_table.id
}
