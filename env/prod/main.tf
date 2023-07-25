module "prod" {
  source = "../../infra/terraform/aws/"

  nome_repositorio = "producao"
  cargo_iam        = "prod"
  ambiente         = "producao"
}

output "IP_alb" {
  value = module.prod.IP
}