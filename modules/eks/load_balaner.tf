resource "helm_release" "eks_load_balance_controller" {
  name       = "aws-load-balance-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"

  set {
    name  = "fullnameOverride"
    value = "${var.cluster_name}-load-balance-controller"
  }

  set {
    name  = "region"
    value = var.region
  }

  set {
    name  = "vpcId"
    value = var.vpc_id
  }

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balance-controller"
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.eks_load_balance_controller_role.arn
  }
  depends_on = [aws_eks_cluster.eks_cluster]
}