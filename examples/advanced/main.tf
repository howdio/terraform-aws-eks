provider "aws" {
  region = "us-west-2"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "v2.18.0"

  name = "eks-gpu"
  cidr = "10.0.0.0/16"

  azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets = ["10.0.64.0/19", "10.0.96.0/19", "10.0.128.0/19"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    "kubernetes.io/cluster/eks-gpu" = "shared"
  }
}

module "eks" {
  source = "../../modules/cluster"

  name       = "eks-gpu"
  vpc_id     = module.vpc.vpc_id
  subnet_ids = flatten([module.vpc.private_subnets, module.vpc.public_subnets])

  enable_kubectl   = true
  enable_kube2iam  = true
  enable_dashboard = true
  enable_calico    = true

  # More details here:
  # https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html
  aws_auth = <<AWSAUTH
  mapUsers: |
    - userarn: arn:aws:iam::555555555555:user/admin
      username: admin
      groups:
        - system:masters
    - userarn: arn:aws:iam::111122223333:user/ops-user
      username: ops-user
      groups:
        - system:masters
AWSAUTH
}

module "eks_nodes_gpu" {
  source = "../../modules/nodes"

  name                = "eks_nodes_gpu"
  cluster_name        = module.eks.name
  cluster_endpoint    = module.eks.endpoint
  cluster_certificate = module.eks.certificate
  security_groups     = [module.eks.node_security_group]
  subnet_ids          = flatten([module.vpc.private_subnets])
  ami_lookup          = "amazon-eks-gpu-node-*"
  instance_type       = "p3.2xlarge"
  bootstrap_arguments = "--kubelet-extra-args --node-labels=billing=on-demand"
  instance_profile    = module.eks.node_instance_profile
  disk_size           = "50"
}

module "eks_nodes_gpu_spot" {
  source = "../../modules/nodes"

  name                = "eks_nodes_gpu_spot"
  cluster_name        = module.eks.name
  cluster_endpoint    = module.eks.endpoint
  cluster_certificate = module.eks.certificate
  security_groups     = [module.eks.node_security_group]
  subnet_ids          = module.vpc.private_subnets
  ami_lookup          = "amazon-eks-gpu-node-*"
  instance_type       = "p3.2xlarge"
  bootstrap_arguments = "--kubelet-extra-args --node-labels=billing=spot"
  instance_profile    = module.eks.node_instance_profile
  spot_price          = "1.10"
  disk_size           = "50"
}

