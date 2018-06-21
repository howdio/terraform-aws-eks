resource "aws_default_vpc" "default" {
  count = "${var.default_vpc ? 1 : 0}"

  tags = "${
    map(
     "kubernetes.io/cluster/${var.name}", "shared",
    )
  }"
}

resource "aws_default_subnet" "default" {
  count             = "${var.default_vpc ? length(local.availability_zones) : 0}"
  availability_zone = "${local.availability_zones[count.index]}"

  tags = "${
    map(
     "kubernetes.io/cluster/${var.name}", "shared",
    )
  }"
}

module "cluster" {
  source = "./modules/cluster"

  name                    = "${var.name}"
  version                 = "${var.version}"
  vpc_id                  = "${local.vpc_id}"
  subnet_ids              = ["${local.cluster_subnet_ids}"]
  workstation_cidr_blocks = ["${var.workstation_cidr_blocks}"]
  enable_kubectl          = "${var.enable_kubectl}"
}

module "nodes" {
  source = "./modules/nodes"

  name                = "${var.name}"
  cluster_name        = "${module.cluster.name}"
  cluster_endpoint    = "${module.cluster.endpoint}"
  cluster_certificate = "${module.cluster.certificate}"
  security_groups     = ["${module.cluster.node_security_group}"]
  instance_profile    = "${module.cluster.node_instance_profile}"
  subnet_ids          = ["${local.node_subnet_ids}"]
  instance_type       = "${var.node_instance_type}"
  user_data           = "${var.node_user_data}"
  min_size            = "${var.node_min_size}"
  max_size            = "${var.node_max_size}"
  key_pair            = "${var.key_pair}"
}
