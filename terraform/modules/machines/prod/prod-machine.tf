module "prod" {
  source            = "../../../"
  regiao            = "sa-east-1a"
  tipo_da_instancia = "t2.micro"
  chave             = "ansible-terraform"
  grupo_seg         = "prod"
  autoscale_min     = 1
  autoscale_max     = 5
}
