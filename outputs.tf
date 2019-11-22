output "cluster_name" {
  value       = module.cluster.name
  description = "Cluster name provided when the cluster was created."
}

output "cluster_endpoint" {
  value       = module.cluster.endpoint
  description = "Endpoint of the Kubernetes Control Plane."
}

output "cluster_certificate" {
  value       = module.cluster.certificate
  description = "Certificate used to authenticate to the Kubernetes Controle Plane."
}

output "node_role" {
  value       = module.cluster.node_role
  description = "IAM Role which has the required policies to add the node to the cluster."
}

output "node_role_arn" {
  value       = module.cluster.node_role_arn
  description = "IAM Role ARN which has the required policies to add the node to the cluster."
}

output "cluster_security_group" {
  value       = module.cluster.cluster_security_group
  description = "Security Group between cluster and nodes."
}

output "node_security_group" {
  value       = module.cluster.node_security_group
  description = "Security Group to be able to access to the Kubernetes Control Plane and other nodes."
}

output "node_instance_profile" {
  value       = module.cluster.node_instance_profile
  description = "IAM Instance Profile which has the required policies to add the node to the cluster."
}

output "node_instance_profile_arn" {
  value       = module.cluster.node_instance_profile_arn
  description = "IAM Instance Profile ARN which has the required policies to add the node to the cluster."
}

output "kubeconfig" {
  value       = module.cluster.kubeconfig
  description = "Kubernetes configuration file for accessing the cluster using the Kubernete CLI."
}

