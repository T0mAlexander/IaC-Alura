module "prod" {
  source = "../../infra/terraform/aws/"

  cluster_name     = "cluster-eks-curso"
  nome_repositorio = "prod"
}

output "endereco" {
  value = module.prod.url
}