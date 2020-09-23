resource "aws_default_vpc" "default" {
  count = var.default_vpc ? 1 : 0

  tags = {
    "kubernetes.io/cluster/${var.name}" = "shared"
  }
}

resource "aws_default_subnet" "default" {
  count             = var.default_vpc ? length(local.availability_zones) : 0
  availability_zone = local.availability_zones[count.index]

  tags = {
    "kubernetes.io/cluster/${var.name}" = "shared"
  }
}

module "cluster" {
  source = "./modules/cluster"

  name             = var.name
  eks_version      = var.eks_version
  vpc_id           = local.vpc_id
  subnet_ids       = [local.cluster_subnet_ids]
  workstation_cidr = [var.workstation_cidr]
  ssh_cidr         = var.ssh_cidr
  enable_kubectl   = var.enable_kubectl
  enable_dashboard = var.enable_dashboard
  enable_calico    = var.enable_calico
  enable_kube2iam  = var.enable_kube2iam
  aws_auth         = var.aws_auth
}

module "nodes" {
  source = "./modules/nodes"

  name                = var.name
  cluster_name        = module.cluster.name
  cluster_endpoint    = module.cluster.endpoint
  cluster_certificate = module.cluster.certificate
  security_groups     = [module.cluster.node_security_group]
  instance_profile    = module.cluster.node_instance_profile
  subnet_ids          = flatten([local.node_subnet_ids])
  ami_id              = var.node_ami_id
  ami_lookup          = var.node_ami_lookup
  instance_type       = var.node_instance_type
  user_data           = var.node_user_data
  bootstrap_arguments = var.node_bootstrap_arguments
  min_size            = var.node_min_size
  max_size            = var.node_max_size
  key_pair            = var.key_pair
  disk_size           = var.node_disk_size
  spot_price          = var.spot_price
}

