# cluster

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| enable_kubectl | When enabled, it will merge the cluster's configuration with the one located in ~/.kube/config. | string | `false` | no |
| name | Name to be used on all the EKS Cluster resources as identifier. | string | - | yes |
| subnet_ids | A list of VPC subnet IDs which the cluster uses. | string | `<list>` | no |
| version | Kubernetes version to use for the cluster. | string | `1.10` | no |
| vpc_id | ID of the VPC where to create the cluster resources. | string | - | yes |
| workstation_cidr_blocks | CIDR blocks from which to allow inbound traffic to the Kubernetes control plane. | string | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| certificate | Certificate used to authenticate to the Kubernetes Controle Plane. |
| endpoint | Endpoint of the Kubernetes Control Plane. |
| kubeconfig | Kubernetes configuration file for accessing the cluster using the Kubernete CLI. |
| name | Cluster name provided when the cluster was created. |
| node_instance_profile | IAM Instance Profile which has the required policies to add the node to the cluster. |
| node_role | IAM Role which has the required policies to add the node to the cluster. |
| node_role_arn | IAM Role ARN which has the required policies to add the node to the cluster. |
| node_security_group | Security Group to be able to access to the Kubernetes Control Plane and other nodes. |

