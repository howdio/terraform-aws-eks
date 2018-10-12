locals {
  ami_id = "${var.node_ami_id != "" ? var.node_ami_id : data.aws_ami.eks_node.id}"

  common_tags = "${map(
    "created_by", "terraform",
    "kubernetes.io/cluster/${var.name}", "owned"
  )}"
}
