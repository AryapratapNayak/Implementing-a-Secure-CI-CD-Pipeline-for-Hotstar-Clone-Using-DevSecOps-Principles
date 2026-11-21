terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.63"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_eks_node_group" "hotstar_workers" {
  cluster_name    = "hotstar-eks"
  node_group_name = "hotstar-workers"
  node_role_arn   = "arn:aws:iam::050797989675:role/eksctl-hotstar-eks-nodegroup-hotst-NodeInstanceRole-pJym6FGMCsxB"

  subnet_ids = [
    "subnet-01147d2f1c18eaebc",
    "subnet-0ffe990cccec17f85",
    "subnet-0287115c31e4fc643"
  ]

  instance_types = ["t3.small"]
  ami_type       = "AL2023_x86_64_STANDARD"
  capacity_type  = "ON_DEMAND"

  launch_template {
    id      = "lt-0b59a911d1ad1f284"
    version = "1"
  }

  scaling_config {
    min_size     = 2
    desired_size = 2
    max_size     = 3
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    "alpha.eksctl.io/cluster-name"   = "hotstar-eks"
    "alpha.eksctl.io/nodegroup-name" = "hotstar-workers"
  }

  tags = {
    "alpha.eksctl.io/cluster-name"                = "hotstar-eks"
    "alpha.eksctl.io/eksctl-version"              = "0.232.0"
    "alpha.eksctl.io/nodegroup-name"              = "hotstar-workers"
    "alpha.eksctl.io/nodegroup-type"              = "managed"
    "eksctl.cluster.k8s.io/v1alpha1/cluster-name" = "hotstar-eks"
  }
  lifecycle {
    prevent_destroy = true
  }
}

