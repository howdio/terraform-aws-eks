locals {
  vpc_id = data.aws_subnet.first.vpc_id
  ami_id = var.ami_id != "" ? var.ami_id : data.aws_ami.eks_node.id

  user_data = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh ${var.cluster_name} ${var.bootstrap_arguments}
${var.user_data}
USERDATA

}

