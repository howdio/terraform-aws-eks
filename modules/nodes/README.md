# nodes

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| ami_id | AMI id for the node instances. | string | `` | no |
| ami_lookup | AMI lookup name for the node instances. | string | `amazon-eks-node-*` | no |
| cluster_certificate | Certificate used to authenticate to the Kubernetes Controle Plane. | string | - | yes |
| cluster_endpoint | Endpoint of the Kubernetes Controle Plane. | string | - | yes |
| cluster_name | Cluster name provided when the cluster was created. If it is incorrect, nodes will not be able to join the cluster. | string | - | yes |
| instance_profile | IAM Instance Profile which has the required policies to add the node to the cluster. | string | - | yes |
| instance_type | EC2 instance type for the node instances. | string | `m5.large` | no |
| key_pair | The EC2 Key Pair to allow SSH access to the instances. | string | `` | no |
| max_size | Maximum size of Node Group ASG. | string | `2` | no |
| min_size | Minimum size of Node Group ASG. | string | `1` | no |
| name | Unique identifier for the Node Group. | string | - | yes |
| security_groups | The security groups assigned to the worker nodes. If it is incorrect, nodes will not be able to reach each other. | list | - | yes |
| subnet_ids | Subnet IDs where worker nodes can be created. | list | - | yes |
| user_data | Additional user data used when bootstrapping the EC2 instance. | string | `` | no |
| bootstrap_arguments | Additional arguments when bootstrapping the EKS node. | string | `` | no |
| disk_size | The root device size for the worker nodes. | string | `` | yes |
| spot_price | The maximum price to use for reserving spot instances. If set, the worker nodes will be spawned as spot instances instead of on demand. | string | `` | no |

