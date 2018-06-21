variable "name" {
  type        = "string"
  description = "Name to be used on all the EKS Cluster resources as identifier."
}

variable "version" {
  default     = "1.10"
  description = "Kubernetes version to use for the cluster."
}

variable "vpc_id" {
  type        = "string"
  description = "ID of the VPC where to create the cluster resources."
}

variable "subnet_ids" {
  default     = []
  description = "A list of VPC subnet IDs which the cluster uses."
}

variable "workstation_cidr_blocks" {
  default     = []
  description = "CIDR blocks from which to allow inbound traffic to the Kubernetes control plane."
}

variable "enable_kubectl" {
  default     = false
  description = "When enabled, it will merge the cluster's configuration with the one located in ~/.kube/config."
}
