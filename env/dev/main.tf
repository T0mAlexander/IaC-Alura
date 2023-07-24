module "dev" {
  source = "../../infra/terraform/aws"

  nome          = "desenvolvimento"
  descricao     = "app-desenvolvimento"
  autoscale_max = 3
  maquina       = "t2.micro"
  ambiente      = "env-dev"
}