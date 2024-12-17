variable "aws_region" {
  description = "The AWS region to deploy resources in"
  default     = "eu-west-2"
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  default     = "web-app-cluster"
}
