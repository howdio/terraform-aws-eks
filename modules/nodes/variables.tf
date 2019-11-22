variable "name" {
  type        = string
  description = "Unique identifier for the Node Group."
}

variable "cluster_name" {
  type        = string
  description = "Cluster name provided when the cluster was created. If it is incorrect, nodes will not be able to join the cluster."
}

variable "cluster_endpoint" {
  type        = string
  description = "Endpoint of the Kubernetes Controle Plane."
}

variable "cluster_certificate" {
  type        = string
  description = "Certificate used to authenticate to the Kubernetes Controle Plane."
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs where worker nodes can be created."
}

variable "security_groups" {
  type        = list(string)
  description = "The security groups assigned to the worker nodes. If it is incorrect, nodes will not be able to reach each other."
}

variable "ami_id" {
  default     = ""
  description = "AMI id for the node instances."
}

variable "ami_lookup" {
  default     = "amazon-eks-node-*"
  description = "AMI lookup name for the node instances."
}

variable "instance_type" {
  default     = "m5.large"
  description = "EC2 instance type for the node instances."
}

variable "instance_profile" {
  type        = string
  description = "IAM Instance Profile which has the required policies to add the node to the cluster."
}

variable "min_size" {
  default     = 1
  description = "Minimum size of Node Group ASG."
}

variable "max_size" {
  default     = 2
  description = "Maximum size of Node Group ASG."
}

variable "bootstrap_arguments" {
  default     = ""
  description = "Additional arguments when bootstrapping the EKS node."
}

variable "disk_size" {
  default     = ""
  description = "The root device size for the worker nodes."
}

variable "user_data" {
  default     = ""
  description = "Additional user data used when bootstrapping the EC2 instance."
}

variable "key_pair" {
  default     = ""
  description = "The EC2 Key Pair to allow SSH access to the instances."
}

variable "spot_price" {
  default     = ""
  description = "The maximum price to use for reserving spot instances. If set, the worker nodes will be spawned as spot instances instead of on demand."
}

