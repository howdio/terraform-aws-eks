## VARIABLES
## ----------------------------------------------------------------------------
variable "name" {
  default     = "eks-advanced"
  description = "Name to be used on all the resources as identifier."
}

variable "aws-region" {
  default     = "eu-west-1"
  description = "The region where all the resources will be created."
}

variable "key_pair" {
  default     = ""
  description = "The EC2 Key Pair to allow SSH access to the instances."
}

variable "rsa-bits" {
  default     = 2048
  description = "The size of the generated RSA key in bits."
}

variable "key-algorithm" {
  default     = "RSA"
  description = "The name of the algorithm to use for the key. Currently-supported values are RSA and ECDSA."
}

variable "ssh-cidr" {
  default     = "83.241.166.2/32"
  description = "The CIDR we're allowing incoming ssh connections to EKS nodes."
}

variable "node_ami_id" {
  default     = ""
  description = "AMI id for the node instances."
}

variable "node_ami_lookup" {
  default     = "amazon-eks-node-*"
  description = "AMI lookup name for the node instances."
}

variable "node_bootstrap_arguments" {
  default     = ""
  description = "Additional arguments when bootstrapping the EKS nodes."
}
