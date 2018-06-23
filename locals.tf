locals {
  vpc_id             = "${var.default_vpc ? data.aws_vpc.default.id : var.vpc_id}"
  cluster_subnet_ids = ["${split(",",var.default_vpc ? join(",",aws_default_subnet.default.*.id) : join(",",var.cluster_subnet_ids))}"]
  node_subnet_ids    = ["${split(",",length(var.node_subnet_ids) == 0 ? join(",",local.cluster_subnet_ids) : join(",",var.node_subnet_ids))}"]
  availability_zones = ["${split(",",length(var.availability_zones) != 0 ? join(",",var.availability_zones) : join(",",slice(data.aws_availability_zones.available.names, 0, var.availability_zone_count)))}"]

  kubeconfig = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: ${module.cluster.endpoint}
    certificate-authority-data: ${module.cluster.certificate}
  name: eks
contexts:
- context:
    cluster: eks
    user: eks
  name: eks
current-context: eks
kind: Config
preferences: {}
users:
- name: eks
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: heptio-authenticator-aws
      args:
        - "token"
        - "-i"
        - "${module.cluster.name}"
KUBECONFIG

  eks_admin = <<EKSADMIN
apiVersion: v1
kind: ServiceAccount
metadata:
  name: eks-admin
  namespace: kube-system

---

apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: eks-admin
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: eks-admin
  namespace: kube-system
EKSADMIN

  kube2iam = <<KUBE2IAM
apiVersion: v1
kind: ServiceAccount
metadata:
  name: kube2iam
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRole
metadata:
  name: kube2iam
  namespace: kube-system
rules:
  - apiGroups: [""]
    resources: ["namespaces","pods"]
    verbs: ["get","watch","list"]
---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: kube2iam
  namespace: kube-system
subjects:
- kind: ServiceAccount
  name: kube2iam
  namespace: kube-system
roleRef:
  kind: ClusterRole
  name: kube2iam
  apiGroup: rbac.authorization.k8s.io
---
apiVersion: extensions/v1beta1
kind: DaemonSet
metadata:
  name: kube2iam
  namespace: kube-system
  labels:
    app: kube2iam
spec:
  template:
    metadata:
      labels:
        name: kube2iam
    spec:
      serviceAccountName: kube2iam
      hostNetwork: true
      containers:
        - image: jtblin/kube2iam:latest
          name: kube2iam
          args:
            - "--auto-discover-base-arn"
            - "--auto-discover-default-role"
            - "--iptables=true"
            - "--host-ip=$(HOST_IP)"
            - "--host-interface=eni+"
            - "--node=$(NODE_NAME)"
          env:
            - name: HOST_IP
              valueFrom:
                fieldRef:
                  fieldPath: status.podIP
            - name: NODE_NAME
              valueFrom:
                fieldRef:
                  fieldPath: spec.nodeName
          ports:
            - containerPort: 8181
              hostPort: 8181
              name: http
          securityContext:
            privileged: true
KUBE2IAM
}
