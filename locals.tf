locals {
  vpc_id             = var.default_vpc ? data.aws_vpc.default.id : var.vpc_id
  cluster_subnet_ids = flatten([split(",", var.default_vpc ? join(",", aws_default_subnet.default.*.id) : join(",", var.cluster_subnet_ids), )])
  node_subnet_ids    = flatten([split(",", length(var.node_subnet_ids) == 0 ? join(",", local.cluster_subnet_ids) : join(",", var.node_subnet_ids), )])
  availability_zones = flatten([split(",", length(var.availability_zones) != 0 ? join(",", var.availability_zones) : join(",", slice(data.aws_availability_zones.available.names, 0, var.availability_zone_count, ), ), )])
}

