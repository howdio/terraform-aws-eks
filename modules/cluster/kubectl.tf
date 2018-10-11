resource "null_resource" "output" {
  provisioner "local-exec" {
    command = "mkdir -p ./output/${var.name}"
  }
}

resource "local_file" "kubeconfig" {
  content  = "${local.kubeconfig}"
  filename = "./output/${var.name}/kubeconfig-${var.name}"

  depends_on = [
    "null_resource.output",
  ]
}

resource "local_file" "aws_auth" {
  content  = "${local.aws_auth}"
  filename = "./output/${var.name}/aws-auth.yaml"

  depends_on = [
    "null_resource.output",
  ]
}

resource "null_resource" "kubectl" {
  count = "${var.enable_kubectl ? 1 : 0}"

  provisioner "local-exec" {
    command = <<COMMAND
      KUBECONFIG=~/.kube/config:./output/${var.name}/kubeconfig-${var.name} kubectl config view --flatten > ./kubeconfig_merged \
      && mv ./kubeconfig_merged ~/.kube/config \
      && kubectl config use-context eks-${var.name}
    COMMAND
  }

  triggers {
    kubeconfig_rendered = "${local.kubeconfig}"
  }

  depends_on = [
    "aws_eks_cluster.cluster",
    "null_resource.output",
  ]
}

resource "null_resource" "aws_auth" {
  provisioner "local-exec" {
    command = "kubectl apply --kubeconfig=./output/${var.name}/kubeconfig-${var.name} -f ./output/${var.name}/aws-auth.yaml"
  }

  triggers {
    kubeconfig_rendered = "${local.kubeconfig}"
  }

  depends_on = [
    "local_file.aws_auth",
    "aws_eks_cluster.cluster",
  ]
}
