resource "local_file" "kubeconfig" {
  count = "${var.enable_kubectl ? 1 : 0}"

  content  = "${local.kubeconfig}"
  filename = "./kubeconfig-${var.name}-cluster"
}

resource "local_file" "aws_auth" {
  content  = "${local.aws_auth}"
  filename = "./aws-auth.yaml"
}

resource "null_resource" "kubectl" {
  count = "${var.enable_kubectl ? 1 : 0}"

  provisioner "local-exec" {
    command = <<COMMAND
      KUBECONFIG=~/.kube/config:./kubeconfig-${var.name}-cluster kubectl config view --flatten > ./kubeconfig_merged \
      && mv ./kubeconfig_merged ~/.kube/config \
      && kubectl config use-context eks-${var.name}
    COMMAND
  }

  triggers {
    kubeconfig_rendered = "${local.kubeconfig}"
  }

  depends_on = [
    "aws_eks_cluster.cluster",
  ]
}

resource "null_resource" "aws_auth" {
  provisioner "local-exec" {
    command = "kubectl apply --kubeconfig=./kubeconfig-${var.name}-cluster -f ./aws-auth.yaml"
  }

  triggers {
    kubeconfig_rendered = "${local.kubeconfig}"
  }

  depends_on = [
    "local_file.aws_auth",
    "aws_eks_cluster.cluster",
  ]
}
