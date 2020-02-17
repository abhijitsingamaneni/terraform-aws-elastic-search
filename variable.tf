variable "domain" {
  default = "elastic-cluster-uat"
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}