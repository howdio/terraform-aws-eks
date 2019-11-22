provider "aws" {
  region = "eu-west-1"
}

module "eks" {
  source = "../../"

  name        = "basic"
  default_vpc = true

  enable_kubectl   = true
  enable_dashboard = true
  enable_kube2iam  = true
}

