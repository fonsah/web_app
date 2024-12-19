output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.this.id
}

output "eks_cluster_name" {
  description = "EKS Cluster Name"
  value       = aws_eks_cluster.this.name
}

output "eks_cluster_endpoint" {
  description = "EKS Cluster Endpoint"
  value       = aws_eks_cluster.this.endpoint
}

output "node_group_role_arn" {
  description = "ARN of the Node Group Role"
  value       = aws_iam_role.node_group_role.arn
}
