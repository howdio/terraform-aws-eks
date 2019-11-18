output "name" {
  value       = aws_eks_cluster.cluster.name
  description = "Cluster name provided when the cluster was created."
}

output "endpoint" {
  value       = aws_eks_cluster.cluster.endpoint
  description = "Endpoint of the Kubernetes Control Plane."
}

output "certificate" {
  value       = aws_eks_cluster.cluster.certificate_authority[0].data
  description = "Certificate used to authenticate to the Kubernetes Controle Plane."
}

output "node_role" {
  value       = aws_iam_role.node.name
  description = "IAM Role which has the required policies to add the node to the cluster."
}

output "node_role_arn" {
  value       = aws_iam_role.node.arn
  description = "IAM Role ARN which has the required policies to add the node to the cluster."
}

output "cluster_security_group" {
  value       = aws_security_group.cluster.id
  description = "Security Group between cluster and nodes."
}

output "node_security_group" {
  value       = aws_security_group.node.id
  description = "Security Group to be able to access to the Kubernetes Control Plane and other nodes."
}

output "node_instance_profile" {
  value       = aws_iam_instance_profile.node.name
  description = "IAM Instance Profile which has the required policies to add the node to the cluster."
}

output "node_instance_profile_arn" {
  value       = aws_iam_instance_profile.node.arn
  description = "IAM Instance Profile ARN which has the required policies to add the node to the cluster."
}

output "kubeconfig" {
  value       = local.kubeconfig
  description = "Kubernetes configuration file for accessing the cluster using the Kubernete CLI."
}

