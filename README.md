
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| availability_zone_count | Number of availability zones used in the region. | string | `2` | no |
| availability_zones | List of availability zones in the region | string | `<list>` | no |
| cluster_subnet_ids | A list of VPC subnet IDs which the cluster uses. | string | `<list>` | no |
| default_vpc | Instance type of the worker node. | string | `false` | no |
| enable_calico | When enabled, it will install Calico for network policy support. | string | `false` | no |
| enable_dashboard | When enabled, it will install the Kubernetes Dashboard. | string | `false` | no |
| enable_kubectl | When enabled, it will merge the cluster's configuration with the one located in ~/.kube/config. | string | `false` | no |
| key_pair | Adds an EC2 Key Pair to the cluster nodes. | string | `` | no |
| name | Name to be used on all the resources as identifier. | string | - | yes |
| node_instance_type | Instance type of the worker node. | string | `m5.large` | no |
| node_max_size | Maximum size of the worker node AutoScaling Group. | string | `2` | no |
| node_min_size | Minimum size of the worker node AutoScaling Group. | string | `1` | no |
| node_subnet_ids | A list of VPC subnet IDs which the worker nodes are using. | string | `<list>` | no |
| node_user_data | Additional user data used when bootstrapping the EC2 instance. | string | `` | no |
| version | Kubernetes version to use for the cluster. | string | `1.10` | no |
| vpc_id | ID of the VPC where to create the cluster resources. | string | `` | no |
| workstation_cidr_blocks | CIDR blocks from which to allow inbound traffic to the Kubernetes control plane. | string | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster_certificate | Certificate used to authenticate to the Kubernetes Controle Plane. |
| cluster_endpoint | Endpoint of the Kubernetes Control Plane. |
| cluster_name | Cluster name provided when the cluster was created. |
| kubeconfig | Kubernetes configuration file for accessing the cluster using the Kubernete CLI. |
| node_instance_profile | IAM Instance Profile which has the required policies to add the node to the cluster. |
| node_role | IAM Role which has the required policies to add the node to the cluster. |
| node_security_group | Security Group to be able to access to the Kubernetes Control Plane and other nodes. |

