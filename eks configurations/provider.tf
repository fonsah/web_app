provider "aws" {
  region = var.region
}

# The Kubernetes provider will be configured after the EKS cluster is created.
provider "kubernetes" {
  host                   = data.aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster_auth.this.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.this.token
}
