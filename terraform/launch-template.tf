resource "aws_launch_template" "maquina" {
  image_id      = var.ubuntu    # Ubuntu Server 22.04 LTS
  instance_type = var.free-tier # Instância do Free Tier da AWS
  key_name      = var.chave-ssh

  vpc_security_group_ids = [aws_security_group.global-security-group.id]
}