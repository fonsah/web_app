output "kubeconfig" {
  description = "Kubeconfig for the EKS cluster"
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

output "cluster_endpoint" {
  description = "EKS cluster endpoint"
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "cluster_security_group_id" {
  description = "Security Group ID for the EKS cluster"
  value = aws_security_group.eks_sg.id
}
