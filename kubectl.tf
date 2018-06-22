resource "local_file" "kubeconfig" {
  count = "${var.enable_dashboard || var.enable_calico || var.enable_kube2iam ? 1 : 0}"

  content  = "${local.kubeconfig}"
  filename = "./kubeconfig-${var.name}"
}

# Dashboard
resource "local_file" "eks_admin" {
  count = "${var.enable_dashboard ? 1 : 0}"

  content  = "${local.eks_admin}"
  filename = "./eks-admin.yaml"
}

resource "local_file" "kube2iam" {
  count = "${var.enable_kube2iam ? 1 : 0}"

  content  = "${local.kube2iam}"
  filename = "./kube2iam.yaml"
}

resource "null_resource" "dashboard" {
  count = "${var.enable_dashboard ? 1 : 0}"

  provisioner "local-exec" {
    command = <<COMMAND
      export KUBECONFIG=./kubeconfig-${var.name} \
      && kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml \
      && kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/influxdb/heapster.yaml \
      && kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/influxdb/influxdb.yaml \
      && kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/rbac/heapster-rbac.yaml \
      && kubectl apply -f eks-admin.yaml \
      && kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep eks-admin | awk '{print $1}')
    COMMAND
  }

  triggers {
    kubeconfig_rendered = "${local.kubeconfig}"
  }

  depends_on = [
    "local_file.eks_admin",
  ]
}

# Calico

resource "null_resource" "calico" {
  count = "${var.enable_calico ? 1 : 0}"

  provisioner "local-exec" {
    command = "kubectl apply -f https://raw.githubusercontent.com/aws/amazon-vpc-cni-k8s/v1.0.0/config/v1.0/aws-k8s-cni-calico.yaml --kubeconfig ./kubeconfig-${var.name}"
  }

  triggers {
    kubeconfig_rendered = "${local.kubeconfig}"
  }
}

resource "null_resource" "kube2iam" {
  count = "${var.enable_kube2iam ? 1 : 0}"

  provisioner "local-exec" {
    command = "kubectl apply -f kube2iam.yaml --kubeconfig ./kubeconfig-${var.name}"
  }

  triggers {
    kubeconfig_rendered = "${local.kubeconfig}"
  }
}
