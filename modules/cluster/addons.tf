# Dashboard
resource "local_file" "eks_admin" {
  count = var.enable_dashboard ? 1 : 0

  content  = local.eks_admin
  filename = "${path.root}/output/${var.name}/eks-admin.yaml"

  depends_on = [null_resource.output]
}

resource "null_resource" "dashboard" {
  count = var.enable_dashboard ? 1 : 0

  provisioner "local-exec" {
    command = <<COMMAND
      export KUBECONFIG=${path.root}/output/${var.name}/kubeconfig-${var.name} \
      && kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/aio/deploy/recommended.yaml \
      && kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/influxdb/heapster.yaml \
      && kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/influxdb/influxdb.yaml \
      && kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/rbac/heapster-rbac.yaml \
      && kubectl apply -f ${path.root}/output/${var.name}/eks-admin.yaml \
      && kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep eks-admin | awk '{print $1}')
    COMMAND
  }

  triggers = {
    kubeconfig_rendered = local.kubeconfig
  }

  depends_on = [local_file.eks_admin]
}

# kube2iam
resource "local_file" "kube2iam" {
  count = var.enable_kube2iam ? 1 : 0

  content  = local.kube2iam
  filename = "${path.root}/output/${var.name}/kube2iam.yaml"

  depends_on = [null_resource.output]
}

resource "null_resource" "kube2iam" {
  count = var.enable_kube2iam ? 1 : 0

  provisioner "local-exec" {
    command = "kubectl apply -f ${path.root}/output/${var.name}/kube2iam.yaml --kubeconfig ${path.root}/output/${var.name}/kubeconfig-${var.name}"
  }

  triggers = {
    kubeconfig_rendered = local.kubeconfig
  }
}

# Calico
resource "null_resource" "calico" {
  count = var.enable_calico ? 1 : 0

  provisioner "local-exec" {
    command = "kubectl apply -f https://raw.githubusercontent.com/aws/amazon-vpc-cni-k8s/release-1.6.1/config/v1.6/aws-k8s-cni.yaml --kubeconfig ${path.root}/output/${var.name}/kubeconfig-${var.name}"
  }

  triggers = {
    kubeconfig_rendered = local.kubeconfig
  }
}

