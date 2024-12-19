resource "aws_eks_cluster" "this" {
  name            = "${var.project_name}-cluster"
  role_arn        = aws_iam_role.eks_cluster_role.arn
  version         = var.cluster_version

  vpc_config {
    subnet_ids = [for subnet in aws_subnet.private : subnet.id]
    security_group_ids = [aws_security_group.cluster.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSVPCResourceController
  ]

  tags = {
    Project = var.project_name
  }
}

resource "aws_eks_node_group" "default" {
  cluster_name    = aws_eks_cluster.this.name
  node_role_arn   = aws_iam_role.node_group_role.arn
  subnet_ids      = [for subnet in aws_subnet.private : subnet.id]
  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }
  instance_types = var.instance_types
  depends_on = [
    aws_iam_role_policy_attachment.nodegroup_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nodegroup_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.nodegroup_AmazonEC2ContainerRegistryReadOnly,
    aws_eks_cluster.this
  ]

  tags = {
    Project = var.project_name
  }
}
