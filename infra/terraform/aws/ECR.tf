resource "aws_ecr_repository" "foo" {
  name         = var.nome_repositorio
  force_delete = true
}