# Basic Kubernetes Cluster
This example will create:
* a new VPC
* a new EKS cluster, using both private and public subnets
* two auto scaling groups to spawn GPU capable working nodes (on-demand and spot instances), using only private subnets

To get the current market price for an instance (`p3.2xlarge`):

```console
$ aws ec2 describe-spot-price-history --start-time=$(date +%s) --product-descriptions="Linux/UNIX" --query 'SpotPriceHistory[*].{az:AvailabilityZone, price:SpotPrice}' --instance-types p3.2xlarge
```

## Usage
To run this example you need to execute:

```bash
terraform init
terraform plan
terraform apply
```

Note that this example may create resources which cost money. Run terraform destroy when you don't need these resources.
