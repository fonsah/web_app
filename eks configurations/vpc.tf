# Fetch available availability zones for the AWS region
data "aws_availability_zones" "available" {}

# Create a VPC
resource "aws_vpc" "eks_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "eks-vpc"
  }
}

# Create Public Subnets
resource "aws_subnet" "eks_public_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = "10.0.${count.index + 1}.0/24"
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "eks-public-subnet-${count.index + 1}"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "eks_igw" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    Name = "eks-igw"
  }
}

# Create a Public Route Table
resource "aws_route_table" "eks_public_route_table" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    Name = "eks-public-route-table"
  }
}

# Add a Route to the Internet Gateway in the Public Route Table
resource "aws_route" "eks_public_route" {
  route_table_id         = aws_route_table.eks_public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.eks_igw.id
}

# Associate Public Subnets with the Public Route Table
resource "aws_route_table_association" "eks_public_route_table_association" {
  count          = 2
  subnet_id      = aws_subnet.eks_public_subnet[count.index].id
  route_table_id = aws_route_table.eks_public_route_table.id
}
