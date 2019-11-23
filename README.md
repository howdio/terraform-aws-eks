# AWS EKS Terraform module
Terraform module which creates EKS resources on AWS.

## Usage
```hcl
module "eks" {
  source = "howdio/eks/aws"

  name        = "cluster"
  default_vpc = true

  enable_kubectl   = true
  enable_dashboard = true
}
```

## Terraform version
Terraform version 0.12+ or newer is required for this module to work.

## Kubernetes CLI
Kubernetes CLI 1.10 or newer with the AWS IAM Authenticator is required for the module to work.

* [Kubernetes Client](https://kubernetes.io/docs/imported/release/notes/#client-binaries)
* [AWS IAM Authenticator](https://github.com/kubernetes-sigs/aws-iam-authenticator)

## Examples
* [basic](https://github.com/howdio/terraform-aws-eks/tree/master/examples/basic) - Create an EKS cluster with GPU capable working nodes.
* [advanced](https://github.com/howdio/terraform-aws-eks/tree/master/examples/advanced) - A more advanced Kubernetes cluster using AWS EKS with multiple instance types worker nodes.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| availability_zone_count | Number of availability zones used in the region. | string | `2` | no |
| availability_zones | List of availability zones in the region | string | `<list>` | no |
| cluster_private_access | Indicates whether or not the Amazon EKS private API server endpoint is enabled. | string | `false` | no |
| cluster_public_access | Indicates whether or not the Amazon EKS public API server endpoint is enabled. | string | `true` | no |
| cluster_subnet_ids | A list of VPC subnet IDs which the cluster uses. | string | `<list>` | no |
| default_vpc | Use the default VPC for creating your cluster resources. | string | `false` | no |
| enable_calico | When enabled, it will install Calico for network policy support. | string | `false` | no |
| enable_dashboard | When enabled, it will install the Kubernetes Dashboard. | string | `false` | no |
| enable_kube2iam | When enabled, it will install Kube2IAM to support assigning IAM roles to Pods. | string | `false` | no |
| enable_kubectl | When enabled, it will merge the cluster's configuration with the one located in ~/.kube/config. | string | `false` | no |
| key_pair | Adds an EC2 Key Pair to the cluster nodes. | string | `` | no |
| ssh_cidr | The CIDR blocks from which to allow incoming ssh connections to the EKS nodes. | string | `<list>` | no |
| name | Name to be used on all the resources as identifier. | string | - | yes |
| node_ami_id | AMI id for the node instances. | string | `` | no |
| node_ami_lookup | AMI lookup name for the node instances. | string | `amazon-eks-node-*` | no |
| node_instance_type | Instance type of the worker node. | string | `m5.large` | no |
| node_max_size | Maximum size of the worker node AutoScaling Group. | string | `2` | no |
| node_min_size | Minimum size of the worker node AutoScaling Group. | string | `1` | no |
| node_subnet_ids | A list of VPC subnet IDs which the worker nodes are using. | string | `<list>` | no |
| node_user_data | Additional user data used when bootstrapping the EC2 instance. | string | `` | no |
| node_bootstrap_arguments | Additional arguments when bootstrapping the EKS node. | string | `` | no |
| node_disk_size | The root device size for the worker nodes. | number | `20` | no |
| eks_version | Kubernetes version to use for the cluster. | string | `1.14` | no |
| vpc_id | ID of the VPC where to create the cluster resources. | string | `` | no |
| workstation_cidr | CIDR blocks from which to allow inbound traffic to the Kubernetes control plane. | string | `<list>` | no |
| aws_auth | Grant additional AWS users or roles the ability to interact with the EKS cluster. | string | `<list>` | no |
| spot_price | The maximum price to use for reserving spot instances. If set, the worker nodes will be spawned as spot instances instead of on demand. | string | `` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster_certificate | Certificate used to authenticate to the Kubernetes Controle Plane. |
| cluster_endpoint | Endpoint of the Kubernetes Control Plane. |
| cluster_name | Cluster name provided when the cluster was created. |
| kubeconfig | Kubernetes configuration file for accessing the cluster using the Kubernete CLI. |
| node_instance_profile | IAM Instance Profile which has the required policies to add the node to the cluster. |
| node_instance_profile_arn | IAM Instance Profile ARN which has the required policies to add the node to the cluster. |
| node_role | IAM Role which has the required policies to add the node to the cluster. |
| node_role_arn | IAM Role ARN which has the required policies to add the node to the cluster. |
| cluster_security_group | Security Group between cluster and nodes. |
| node_security_group | Security Group to be able to access to the Kubernetes Control Plane and other nodes. |

## Contributors
Thank you for your contributions.

* [eana](https://github.com/eana)
