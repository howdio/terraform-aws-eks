data "aws_availability_zones" "available" {
}

data "aws_vpc" "default" {
  id      = var.vpc_id
  default = var.default_vpc
}

