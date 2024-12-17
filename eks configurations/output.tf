output "eks_cluster_id" {
  description = "The ID of the EKS cluster"
  value       = module.eks.cluster_id
}

output "eks_cluster_endpoint" {
  description = "The endpoint for the EKS cluster"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_certificate_authority" {
  description = "The EKS cluster certificate authority data"
  value       = module.eks.cluster_certificate_authority_data
}

output "worker_node_group_arns" {
  description = "ARNs of the worker node groups"
  value       = module.eks.eks_managed_node_groups
}
