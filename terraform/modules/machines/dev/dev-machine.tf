module "dev" {
  source              = "../../../"
  regiao              = "sa-east-1a"
  tipo_da_instancia   = "t2.micro"
  chave               = "ansible-terraform"
  grupo_seg           = "dev"
  autoscale_min       = 1
  autoscale_max       = 3
  nome_do_agrupamento = "desenvolvimento"
  prod                = false
}
