# Advanced Kubernetes Cluster
This example will create a more advanced Kubernetes cluster using AWS EKS with multiple instance types worker nodes.

* the cluster will be deployed in an already existing VPC (named `VPC-TEST`) and will use ONLY the private subnets (tagged with `Tier = "Private"`).
* three Auto Scaling Groups for the worker nodes will be created (`eks-advanced-m4-2xlarge`, `eks-advanced-c4-2xlarge` and `eks-advanced-r4-xlarge`).
* if `key_pair` is not specified a new ssh key will be created and attached to the worker nodes.

## Usage
To run this example you need to execute:

```bash
terraform init
terraform plan
terraform apply
```

Note that this example may create resources which cost money. Run terraform destroy when you don't need these resources.