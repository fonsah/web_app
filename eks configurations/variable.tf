variable "project_name" {
  type        = string
  description = "A prefix for naming all resources."
  default     = "my-eks-project"
}

variable "region" {
  type        = string
  description = "AWS region to deploy resources."
  default     = "eu-west-2"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

variable "public_subnets_cidr" {
  type        = list(string)
  description = "List of public subnet CIDR blocks."
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets_cidr" {
  type        = list(string)
  description = "List of private subnet CIDR blocks."
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "cluster_version" {
  type        = string
  description = "EKS cluster version."
  default     = "1.27"
}

variable "instance_types" {
  type        = list(string)
  description = "Instance types for worker nodes."
  default     = ["t3.small"]
}

variable "desired_size" {
  type        = number
  description = "Desired number of worker nodes."
  default     = 2
}

variable "max_size" {
  type        = number
  description = "Maximum number of worker nodes."
  default     = 4
}

variable "min_size" {
  type        = number
  description = "Minimum number of worker nodes."
  default     = 2
}
