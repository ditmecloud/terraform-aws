## cluster
resource "aws_security_group" "eks_security_group_cluster" {
  name        = "${var.cluster_name}-cluster"
  description = "security group for eks cluster"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_block]
  }

  tags = {
    Name    = "${var.cluster_name}-cluster"
    Project = var.cluster_name
  }
}

resource "aws_security_group_rule" "eks_ingress_cluster_https_rule" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [var.cidr_block]
  security_group_id = aws_security_group.eks_security_group_cluster.id
  description       = "allow https access to worker nodes"
}

## node

resource "aws_security_group" "eks_security_group_node" {
  name        = "${var.cluster_name}-eks-node"
  description = "security group for eks nodes"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.cluster_name}-eks-node"
    Project = var.cluster_name
  }
}

resource "aws_security_group_rule" "eks_ingress_node_cluster_rule" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.eks_security_group_cluster.id
  security_group_id        = aws_security_group.eks_security_group_node.id
  description              = "allow traffic from eks cluster"
}

resource "aws_security_group_rule" "eks_ingress_nodeport_range_rule" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [var.cidr_block]
  security_group_id = aws_security_group.eks_security_group_node.id
  description       = "allow traffic from vpc"
}