provider "aws" {
  region = "us-west-2"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "advanced"
  cidr = "10.0.0.0/16"

  azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets = ["10.0.64.0/19", "10.0.96.0/19", "10.0.128.0/19"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    "kubernetes.io/cluster/advanced" = "shared"
  }
}

module "eks" {
  source = "../../"

  name               = "advanced"
  vpc_id             = "${module.vpc.vpc_id}"
  cluster_subnet_ids = ["${module.vpc.private_subnets}", "${module.vpc.public_subnets}"]
  node_subnet_ids    = ["${module.vpc.private_subnets}"]

  enable_kubectl   = true
  enable_kube2iam  = true
  enable_dashboard = true
  enable_calico    = true
}

module "eks_nodes_gpu" {
  source = "../../modules/nodes"

  name                = "advanced-gpu"
  cluster_name        = "${module.eks.cluster_name}"
  cluster_endpoint    = "${module.eks.cluster_endpoint}"
  cluster_certificate = "${module.eks.cluster_certificate}"
  security_groups     = ["${module.eks.node_security_group}"]
  subnet_ids          = "${module.vpc.private_subnets}"
  ami_lookup          = "amazon-eks-gpu-node-*"
  instance_type       = "p3.2xlarge"
  instance_profile    = "${module.eks.node_instance_profile}"
}
