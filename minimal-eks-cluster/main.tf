provider "aws" {
  region = "us-east-1"  
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.19.0"  

  name = "eks-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]  
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.3.0/24", "10.0.4.0/24"]

  enable_nat_gateway = true
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "20.34.0"  
  cluster_name    = "minimal-eks-cluster"
  cluster_version = "1.32"  

  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.private_subnets

  node_groups = {
    eks_nodes = {
      desired_capacity = 2
      min_capacity     = 2
      max_capacity     = 2
      instance_type    = "t3.micro"  
    }
  }
}
