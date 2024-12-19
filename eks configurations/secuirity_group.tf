# EKS cluster security group: Control plane uses it
resource "aws_security_group" "cluster" {
  name        = "${var.project_name}-eks-cluster-sg"
  description = "EKS Cluster security group"
  vpc_id      = aws_vpc.this.id

  # Allow inbound from worker nodes on the Kubernetes port
  ingress {
    description = "Allow nodes to communicate with the cluster API"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    # Node group SG will reference this SG. We'll add that after SG is created.
    security_groups = []
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project_name}-cluster-sg"
    Project = var.project_name
  }
}

# Node group security group
resource "aws_security_group" "node_group" {
  name        = "${var.project_name}-node-group-sg"
  description = "Node Group security group"
  vpc_id      = aws_vpc.this.id

  ingress {
    description     = "Allow node to node communication (internal)"
    from_port       = 0
    to_port         = 65535
    protocol        = "tcp"
    cidr_blocks     = [aws_vpc.this.cidr_block]
  }

  ingress {
    description     = "Allow pods to communicate with cluster API"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.cluster.id]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project_name}-node-sg"
    Project = var.project_name
  }
}

# Update cluster SG ingress to allow from node SG now that we have node SG ID
resource "aws_security_group_rule" "cluster_from_nodes" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.cluster.id
  source_security_group_id = aws_security_group.node_group.id
  description              = "Allow node group to connect to cluster API"
}
