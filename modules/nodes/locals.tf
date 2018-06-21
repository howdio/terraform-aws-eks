locals {
  vpc_id = "${data.aws_subnet.first.vpc_id}"
  ami_id = "${var.ami_id != "" ? var.ami_id : data.aws_ami.eks_node.id}"

  user_data = <<USERDATA
#!/bin/bash -xe
CA_CERTIFICATE_DIRECTORY=/etc/kubernetes/pki
CA_CERTIFICATE_FILE_PATH=$CA_CERTIFICATE_DIRECTORY/ca.crt
mkdir -p $CA_CERTIFICATE_DIRECTORY
echo "${var.cluster_certificate}" | base64 -d > $CA_CERTIFICATE_FILE_PATH
INTERNAL_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
sed -i s,MASTER_ENDPOINT,${var.cluster_endpoint},g /var/lib/kubelet/kubeconfig
sed -i s,CLUSTER_NAME,${var.cluster_name},g /var/lib/kubelet/kubeconfig
sed -i s,REGION,${data.aws_region.current.name},g /etc/systemd/system/kubelet.service
sed -i s,MAX_PODS,${lookup(local.max_pods, var.instance_type, 8)},g /etc/systemd/system/kubelet.service
sed -i s,MASTER_ENDPOINT,${var.cluster_endpoint},g /etc/systemd/system/kubelet.service
sed -i s,INTERNAL_IP,$INTERNAL_IP,g /etc/systemd/system/kubelet.service
DNS_CLUSTER_IP=10.100.0.10
if [[ $INTERNAL_IP == 10.* ]] ; then DNS_CLUSTER_IP=172.20.0.10; fi
sed -i s,DNS_CLUSTER_IP,$DNS_CLUSTER_IP,g /etc/systemd/system/kubelet.service
sed -i s,CERTIFICATE_AUTHORITY_FILE,$CA_CERTIFICATE_FILE_PATH,g /var/lib/kubelet/kubeconfig
sed -i s,CLIENT_CA_FILE,$CA_CERTIFICATE_FILE_PATH,g  /etc/systemd/system/kubelet.service
systemctl daemon-reload
systemctl restart kubelet kube-proxy
${var.user_data}
USERDATA

  max_pods = {
    "c4.large"    = 29
    "c4.xlarge"   = 58
    "c4.2xlarge"  = 58
    "c4.4xlarge"  = 234
    "c4.8xlarge"  = 234
    "c5.large"    = 29
    "c5.xlarge"   = 58
    "c5.2xlarge"  = 58
    "c5.4xlarge"  = 234
    "c5.9xlarge"  = 234
    "c5.18xlarge" = 737
    "i3.large"    = 29
    "i3.xlarge"   = 58
    "i3.2xlarge"  = 58
    "i3.4xlarge"  = 234
    "i3.8xlarge"  = 234
    "i3.16xlarge" = 737
    "m3.medium"   = 12
    "m3.large"    = 29
    "m3.xlarge"   = 58
    "m3.2xlarge"  = 118
    "m4.large"    = 20
    "m4.xlarge"   = 58
    "m4.2xlarge"  = 58
    "m4.4xlarge"  = 234
    "m4.10xlarge" = 234
    "m5.large"    = 29
    "m5.xlarge"   = 58
    "m5.2xlarge"  = 58
    "m5.4xlarge"  = 234
    "m5.12xlarge" = 234
    "m5.24xlarge" = 737
    "p2.xlarge"   = 58
    "p2.8xlarge"  = 234
    "p2.16xlarge" = 234
    "p3.2xlarge"  = 58
    "p3.8xlarge"  = 234
    "p3.16xlarge" = 234
    "r3.xlarge"   = 58
    "r3.2xlarge"  = 58
    "r3.4xlarge"  = 234
    "r3.8xlarge"  = 234
    "r4.large"    = 29
    "r4.xlarge"   = 58
    "r4.2xlarge"  = 58
    "r4.4xlarge"  = 234
    "r4.8xlarge"  = 234
    "r4.16xlarge" = 737
    "t2.small"    = 8
    "t2.medium"   = 17
    "t2.large"    = 35
    "t2.xlarge"   = 44
    "t2.2xlarge"  = 44
    "x1.16xlarge" = 234
    "x1.32xlarge" = 234
  }
}
