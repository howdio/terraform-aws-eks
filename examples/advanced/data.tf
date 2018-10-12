## DATA
## ----------------------------------------------------------------------------
data "aws_ami" "eks_node" {
  filter {
    name   = "name"
    values = ["${var.node_ami_lookup}"]
  }

  most_recent = true
  owners      = ["602401143452", "679593333241"] # Amazon Account ID
}

data "aws_vpc" "vpc-test" {
  tags {
    Name = "VPC-TEST"
  }
}

data "aws_subnet_ids" "private" {
  vpc_id = "${data.aws_vpc.vpc-test.id}"

  tags {
    Tier = "Private"
  }
}
