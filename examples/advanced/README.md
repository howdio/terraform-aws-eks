# Basic Kubernetes Cluster
This example will create:
* a new VPC
* a new EKS cluster with GPU capable working nodes (using both private and public subnets).

## Usage
To run this example you need to execute:

```bash
terraform init
terraform plan
terraform apply
```

Note that this example may create resources which cost money. Run terraform destroy when you don't need these resources.
