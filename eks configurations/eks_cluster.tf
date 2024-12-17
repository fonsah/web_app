module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "19.18.0"
  cluster_name    = "web-app-cluster"
  cluster_version = "1.27"

  subnet_ids = concat(aws_subnet.public_subnets[*].id, aws_subnet.private_subnets[*].id)
  vpc_id     = aws_vpc.eks_vpc.id

  eks_managed_node_groups = {
    eks_nodes = {
      desired_capacity = 2
      min_size         = 2
      max_size         = 3
      instance_types   = ["t3.medium"]
      capacity_type    = "ON_DEMAND"

      tags = {
        "kubernetes.io/cluster/web-app-cluster" = "owned"
        "Name"                                 = "eks-worker-node"
      }
    }
  }
}
