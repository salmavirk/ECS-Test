data "aws_caller_identity" "current" {}

locals {
  aws_account_id  = "data.aws_caller_identity.current.account_id"
  aws_account_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
}
