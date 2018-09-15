locals {
  kubeconfig = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.cluster.endpoint}
    certificate-authority-data: ${aws_eks_cluster.cluster.certificate_authority.0.data}
  name: eks-${aws_eks_cluster.cluster.name}
contexts:
- context:
    cluster: eks-${aws_eks_cluster.cluster.name}
    user: eks-${aws_eks_cluster.cluster.name}
  name: eks-${aws_eks_cluster.cluster.name}
current-context: eks-${aws_eks_cluster.cluster.name}
kind: Config
preferences: {}
users:
- name: eks-${aws_eks_cluster.cluster.name}
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${aws_eks_cluster.cluster.name}"
KUBECONFIG

  aws_auth = <<AWSAUTH
apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: ${aws_iam_role.node.arn}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
AWSAUTH
}
