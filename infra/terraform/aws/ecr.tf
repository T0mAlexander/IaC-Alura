resource "aws_ecr_repository" "repositorio" {
  name         = var.nome
  force_delete = true
}