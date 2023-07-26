module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.3"

  cluster_name                   = var.cluster_name
  cluster_version                = "1.27"
  cluster_endpoint_public_access = true
  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets

  eks_managed_node_groups = {
    alura = {
      min_size     = 1
      max_size     = 5
      desired_size = 2 # Equivalente ao mínimo de replicas

      vpc_security_groups_ids = [aws_security_group.ssh_cluster.id]
      instance_types          = ["t2.micro"]
    }
  }
}

# Após a criação do cluster EKS, execute o comando "aws eks update-kubeconfig --region <região-aws> --name <nome-do-cluster> para atualizar o arquivo e estabelecer uma conexão com o cluster remoto