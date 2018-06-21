# Basic Kubernetes Cluster
This is example will create a basic Kubernetes cluster using AWS EKS. It uses the account's default VPC and subnets to provision the worker nodes.

Note that is not recommended to use this example with production workloads.

## Usage
To run this example you need to execute:

```bash
terraform init
terraform plan
terraform apply
```

Note that this example may create resources which cost money. Run terraform destroy when you don't need these resources.
