module "prod" {
  source = "../../infra/terraform/aws"

  nome          = "producao"
  descricao     = "app-producao"
  autoscale_max = 5
  maquina       = "t2.micro"
  ambiente      = "env-prod"
}