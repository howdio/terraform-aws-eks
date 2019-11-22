# cluster

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| enable_calico | When enabled, it will install Calico for network policy support. | string | `false` | no |
| enable_dashboard | When enabled, it will install the Kubernetes Dashboard. | string | `false` | no |
| enable_kube2iam | When enabled, it will install Kube2IAM to support assigning IAM roles to Pods. | string | `false` | no |
| enable_kubectl | When enabled, it will merge the cluster's configuration with the one located in ~/.kube/config. | string | `false` | no |
| name | Name to be used on all the EKS Cluster resources as identifier. | string | - | yes |
| subnet_ids | A list of VPC subnet IDs which the cluster uses. | string | `<list>` | no |
| eks_version | Kubernetes version to use for the cluster. | string | `1.14` | no |
| vpc_id | ID of the VPC where to create the cluster resources. | string | - | yes |
| workstation_cidr | CIDR blocks from which to allow inbound traffic to the Kubernetes control plane. | string | `<list>` | no |
| ssh_cidr | The CIDR blocks from which to allow incoming ssh connections to the EKS nodes. | string | `<list>` | no |
| aws_auth | Grant additional AWS users or roles the ability to interact with the EKS cluster. | string | `<list>` | no |
| permissions_boundary | If provided, all IAM roles will be created with this permissions boundary attached. | string | `""` | no |
| cluster_private_access | Indicates whether or not the Amazon EKS private API server endpoint is enabled. | string | `false` | no |
| cluster_public_access | Indicates whether or not the Amazon EKS public API server endpoint is enabled. | string | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| name | Cluster name provided when the cluster was created. |
| endpoint | Endpoint of the Kubernetes Control Plane. |
| certificate | Certificate used to authenticate to the Kubernetes Controle Plane. |
| node_role | IAM Role which has the required policies to add the node to the cluster. |
| node_role_arn | IAM Role ARN which has the required policies to add the node to the cluster. |
| cluster_security_group | Security Group between cluster and nodes. |
| node_security_group | Security Group to be able to access to the Kubernetes Control Plane and other nodes. |
| node_instance_profile | IAM Instance Profile which has the required policies to add the node to the cluster. |
| node_instance_profile_arn | IAM Instance Profile ARN which has the required policies to add the node to the cluster. |
| kubeconfig | Kubernetes configuration file for accessing the cluster using the Kubernete CLI. |

