variable "name" {
  type        = string
  description = "Name to be used on all the EKS Cluster resources as identifier."
}

variable "eks_version" {
  default     = "1.14"
  description = "Kubernetes version to use for the cluster."
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC where to create the cluster resources."
}

variable "subnet_ids" {
  default     = []
  description = "A list of VPC subnet IDs which the cluster uses."
}

variable "workstation_cidr" {
  default     = []
  description = "CIDR blocks from which to allow inbound traffic to the Kubernetes control plane."
}

variable "ssh_cidr" {
  default     = ""
  description = "The CIDR blocks from which to allow incoming ssh connections to the EKS nodes."
}

variable "enable_kubectl" {
  default     = false
  description = "When enabled, it will merge the cluster's configuration with the one located in ~/.kube/config."
}

variable "enable_dashboard" {
  default     = false
  description = "When enabled, it will install the Kubernetes Dashboard."
}

variable "enable_calico" {
  default     = false
  description = "When enabled, it will install Calico for network policy support."
}

variable "enable_kube2iam" {
  default     = false
  description = "When enabled, it will install Kube2IAM to support assigning IAM roles to Pods."
}

variable "aws_auth" {
  default     = ""
  description = "Grant additional AWS users or roles the ability to interact with the EKS cluster."
}

variable "permissions_boundary" {
  default     = ""
  description = "If provided, all IAM roles will be created with this permissions boundary attached."
}

variable "cluster_private_access" {
  default     = false
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled."
}

variable "cluster_public_access" {
  default     = true
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled."
}

