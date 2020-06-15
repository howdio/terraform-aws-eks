resource "null_resource" "output" {
  provisioner "local-exec" {
    command = "mkdir -p ${path.root}/output/${var.name}"
  }
}

resource "local_file" "kubeconfig" {
  content  = local.kubeconfig
  filename = "${path.root}/output/${var.name}/kubeconfig-${var.name}"

  depends_on = [null_resource.output]
}

resource "local_file" "aws_auth" {
  content  = local.aws_auth
  filename = "${path.root}/output/${var.name}/aws-auth.yaml"

  depends_on = [null_resource.output]
}

resource "null_resource" "kubectl" {
  count = var.enable_kubectl ? 1 : 0

  provisioner "local-exec" {
    command = <<COMMAND
      kubectl config unset users.${var.name} \
      && kubectl config unset contexts.${var.name} \
      && kubectl config unset clusters.${var.name} \
      && KUBECONFIG=~/.kube/config:./output/${var.name}/kubeconfig-${var.name} kubectl config view --flatten > ./output/${var.name}/kubeconfig_merged \
      && mv ./output/${var.name}/kubeconfig_merged ~/.kube/config \
      && kubectl config use-context ${var.name}
    COMMAND
  }

  triggers = {
    kubeconfig_rendered = local.kubeconfig
  }

  depends_on = [
    aws_eks_cluster.cluster,
    null_resource.output,
  ]
}

resource "null_resource" "aws_auth" {
  provisioner "local-exec" {
    command = "kubectl apply --kubeconfig=${path.root}/output/${var.name}/kubeconfig-${var.name} -f ${path.root}/output/${var.name}/aws-auth.yaml"
  }

  triggers = {
    kubeconfig_rendered = local.kubeconfig
  }

  depends_on = [
    local_file.aws_auth,
    aws_eks_cluster.cluster,
  ]
}

