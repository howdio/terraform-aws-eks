variable "name" {
  type        = string
  description = "Name to be used on all the resources as identifier."
}

variable "eks_version" {
  default     = "1.14"
  description = "Kubernetes version to use for the cluster."
}

variable "availability_zones" {
  default     = []
  description = "List of availability zones in the region"
}

variable "availability_zone_count" {
  default     = 2
  description = "Number of availability zones used in the region."
}

variable "default_vpc" {
  default     = false
  description = "Use the default VPC for creating your cluster resources."
}

variable "vpc_id" {
  default     = ""
  description = "ID of the VPC where to create the cluster resources."
}

variable "cluster_private_access" {
  default     = false
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled."
}

variable "cluster_public_access" {
  default     = true
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled."
}

variable "cluster_subnet_ids" {
  default     = []
  description = "A list of VPC subnet IDs which the cluster uses."
}

variable "node_ami_id" {
  default     = ""
  description = "AMI id for the node instances."
}

variable "node_ami_lookup" {
  default     = "amazon-eks-node-*"
  description = "AMI lookup name for the node instances."
}

variable "node_subnet_ids" {
  default     = []
  description = "A list of VPC subnet IDs which the worker nodes are using."
}

variable "node_instance_type" {
  default     = "m5.large"
  description = "Instance type of the worker node."
}

variable "node_min_size" {
  default     = 1
  description = "Minimum size of the worker node AutoScaling Group."
}

variable "node_max_size" {
  default     = 2
  description = "Maximum size of the worker node AutoScaling Group."
}

variable "node_user_data" {
  default     = ""
  description = "Additional user data used when bootstrapping the EC2 instance."
}

variable "node_bootstrap_arguments" {
  default     = ""
  description = "Additional arguments when bootstrapping the EKS node."
}

variable "node_disk_size" {
  default     = 20
  description = "The root device size for the worker nodes."
}

variable "workstation_cidr" {
  default     = []
  description = "CIDR blocks from which to allow inbound traffic to the Kubernetes control plane."
}

variable "key_pair" {
  default     = ""
  description = "Adds an EC2 Key Pair to the cluster nodes."
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

variable "spot_price" {
  default     = ""
  description = "The maximum price to use for reserving spot instances. If set, the worker nodes will be spawned as spot instances instead of on demand."
}

