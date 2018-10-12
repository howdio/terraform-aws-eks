# AWS EKS Terraform module
Terraform module which creates EKS resources on AWS.

## Terraform version
Terraform version 0.10.3 or newer is required for this module to work.

## Kubernetes CLI
Kubernetes CLI 1.10 or newer with the AWS IAM Authenticator is required for the module to work.

* [Kubernetes Client](https://kubernetes.io/docs/imported/release/notes/#client-binaries)
* [AWS IAM Authenticator](https://github.com/kubernetes-sigs/aws-iam-authenticator)

## Examples
* [basic](https://github.com/howdio/terraform-aws-eks/tree/master/examples/basic) - Create an EKS cluster with GPU capable working nodes.
* [advanced](https://github.com/howdio/terraform-aws-eks/tree/master/examples/advanced) - A more advanced Kubernetes cluster using AWS EKS with multiple instance types worker nodes.

## Contributors
Thank you for your contributions.

* [eana](https://github.com/eana)
