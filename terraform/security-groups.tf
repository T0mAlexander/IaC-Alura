resource "aws_security_group" "global-security-group" {
  name = var.grupo_seg
  # Regra para permitir todo o tráfego
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.cidr-remote-access
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.cidr-remote-access
  }

  tags = {
    Name = "Grupo de Segurança Geral"
  }
}