module "prod" {
  source              = "../../../"
  tipo_da_instancia   = "t2.micro"
  regiao              = "sa-east-1a"
  chave               = "ansible-terraform"
  grupo_seg           = "producao"
  autoscale_min       = 1
  autoscale_max       = 5
  nome_do_agrupamento = "prod"
}
