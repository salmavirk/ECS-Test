variable "instance_type" {
  type    = string
  default = "t2.micro" # Possibly move to t3 instead
}

variable "assign_public_ipv4" {
  type    = bool
  default = false
}

variable "aws_region" {
 type = string
}

# Can add as many regions are needed
variable "ami_map" {
 type = "map"

  default = {
    us-east-1 = "ami-0f40b95405174b775"
    us-east-2 = "ami-044c86b5209b68ec5"
    us-west-2 = "ami-03304bfe9fdd64784"
    eu-west-1 = "ami-0713a3840a5ddccbe"
    eu-west-2 = "ami-09bec31cd44d129e6"
    ap-southeast-1 = "ami-048b2d5393310e1f7"
    ap-northeast-2 = "ami-07edd45f89412ebaf"
  }
}
