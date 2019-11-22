data "aws_iam_policy_document" "node_assume_kube2iam_role" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "node_kube2iam_policy" {
  count = var.enable_kube2iam ? 1 : 0

  name = "EKSNodeKube2IAMPolicy"
  role = module.cluster.node_role

  policy = data.aws_iam_policy_document.node_assume_kube2iam_role.json
}

