provider "aws" {
  region = "${var.aws_region}"
  version    = "~> 2.12"
}

provider "template" {
  version = "~> 2.1"
}
