resource "aws_launch_template" "maquina" {
  name_prefix   = "maquina"
  image_id      = var.ubuntu    # Ubuntu Server 22.04 LTS
  instance_type = var.free-tier # Instância do Free Tier da AWS
  key_name      = var.chave

  security_group_names = [var.grupo_seg]

  user_data = var.prod ? ("/home/tom/Documents/Projetos/CICD-Alura/terraform/scripts/ansible.sh") : ""
}