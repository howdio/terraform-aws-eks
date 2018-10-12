## PROVIDER
## ----------------------------------------------------------------------------
provider "aws" {
  region = "${var.aws-region}"
}

## SSH-key
## ----------------------------------------------------------------------------
resource "null_resource" "output" {
  provisioner "local-exec" {
    command = "mkdir -p ./output/${var.name}"
  }
}

resource "tls_private_key" "ssh-key" {
  algorithm = "${var.key-algorithm}"
  rsa_bits  = "${var.rsa-bits}"
}

resource "aws_key_pair" "ssh-key-pair" {
  key_name   = "${var.name}-key"
  public_key = "${tls_private_key.ssh-key.public_key_openssh}"
}

resource "local_file" "ssh-key" {
  content  = "${tls_private_key.ssh-key.private_key_pem}"
  filename = "./output/${var.name}/root.pem"

  depends_on = [
    "null_resource.output",
  ]
}

resource "null_resource" "ssh-key" {
  provisioner "local-exec" {
    command = "chmod 600 ./output/${var.name}/root.pem"
  }

  triggers {
    content = "${local_file.ssh-key.content}"
  }

  depends_on = [
    "local_file.ssh-key",
  ]
}

## EKS
## ----------------------------------------------------------------------------
module "eks" {
  source = "../../modules/cluster/"

  name       = "${var.name}"
  vpc_id     = "${data.aws_vpc.vpc-test.id}"
  subnet_ids = ["${data.aws_subnet_ids.private.ids}"]

  enable_kubectl   = false
  enable_kube2iam  = true
  enable_dashboard = true
  enable_calico    = true
}

module "jenkins-master" {
  source = "../../modules/nodes/"

  name                = "${var.name}-m4-2xlarge"
  cluster_name        = "${module.eks.name}"
  cluster_endpoint    = "${module.eks.endpoint}"
  cluster_certificate = "${module.eks.certificate}"
  security_groups     = ["${module.eks.node_security_group}"]
  instance_profile    = "${module.eks.node_instance_profile}"
  subnet_ids          = ["${data.aws_subnet_ids.private.ids}"]
  ami_id              = "${var.node_ami_id}"
  ami_lookup          = "${var.node_ami_lookup}"
  instance_type       = "m4.2xlarge"
  user_data           = "hostname ${var.name}-m4-2xlarge"
  bootstrap_arguments = "${var.node_bootstrap_arguments}"
  min_size            = 1
  max_size            = 1
  key_pair            = "${var.key_pair != "" ? var.key_pair : aws_key_pair.ssh-key-pair.key_name}"
}

module "cluster-nodes" {
  source = "../../modules/nodes/"

  name                = "${var.name}-c4-2xlarge"
  cluster_name        = "${module.eks.name}"
  cluster_endpoint    = "${module.eks.endpoint}"
  cluster_certificate = "${module.eks.certificate}"
  security_groups     = ["${module.eks.node_security_group}"]
  instance_profile    = "${module.eks.node_instance_profile}"
  subnet_ids          = ["${data.aws_subnet_ids.private.ids}"]
  ami_id              = "${var.node_ami_id}"
  ami_lookup          = "${var.node_ami_lookup}"
  instance_type       = "m5.large"
  user_data           = "hostname ${var.name}-c4-2xlarge"
  bootstrap_arguments = "${var.node_bootstrap_arguments}"
  min_size            = 1
  max_size            = 5
  key_pair            = "${var.key_pair != "" ? var.key_pair : aws_key_pair.ssh-key-pair.key_name}"
}

module "cluster-advanced-nodes" {
  source = "../../modules/nodes/"

  name                = "${var.name}-r4-xlarge"
  cluster_name        = "${module.eks.name}"
  cluster_endpoint    = "${module.eks.endpoint}"
  cluster_certificate = "${module.eks.certificate}"
  security_groups     = ["${module.eks.node_security_group}"]
  instance_profile    = "${module.eks.node_instance_profile}"
  subnet_ids          = ["${data.aws_subnet_ids.private.ids}"]
  ami_id              = "${var.node_ami_id}"
  ami_lookup          = "${var.node_ami_lookup}"
  instance_type       = "r4.xlarge"
  user_data           = "hostname ${var.name}-r4-xlarge"
  bootstrap_arguments = "${var.node_bootstrap_arguments}"
  min_size            = 1
  max_size            = 5
  key_pair            = "${var.key_pair != "" ? var.key_pair : aws_key_pair.ssh-key-pair.key_name}"
}
