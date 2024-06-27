## cluster
resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = true
    subnet_ids              = var.subnet_ids
    security_group_ids      = [aws_security_group.eks_security_group_cluster.id]
  }

  tags = {
    Name    = "${var.cluster_name}-eks"
    Project = var.cluster_name
  }

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}


## node
resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = var.subnet_ids

  launch_template {
    name    = aws_launch_template.eks_launch_template.name
    version = 1
  }

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }


  tags = {
    Name    = "${var.cluster_name}-node-group"
    Project = var.cluster_name
  }
}