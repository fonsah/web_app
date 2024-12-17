variable "aws_region" {
    default = "eu-west-2"
}

variable "cluster_name" {
    default = "web-app-cluster"
}

variable "node_group_size" {
    default = 2
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "Public subnet CIDR blocks"
  default     = ["10.0.1.0/24", "10.0.2.0/24"] # Two subnets for count = 2
}

variable "private_subnets" {
  description = "Private subnet CIDR blocks"
  default     = ["10.0.3.0/24", "10.0.4.0/24"] # Two subnets for count = 2
}

variable "availability_zones" {
  description = "Availability zones"
  default     = ["eu-west-2a", "eu-west-2b"] # Two AZs matching count
}