provider "aws" {
  region = "eu-west-1"
}

module "eks" {
  source = "../../"

  name        = "basic"
  default_vpc = true

  ssh_cidr         = "192.168.1.1/32"

  enable_kubectl   = true
  enable_dashboard = true
  enable_kube2iam  = true
}
