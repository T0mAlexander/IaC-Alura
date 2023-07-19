resource "aws_security_group" "ssh-access" {
  name        = "ssh-access"
  description = "Allow SSH traffic"

  # Regra para permitir tráfego SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.cidr-remote-access
  }

  # Regra para permitir tráfego HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.cidr-remote-access
  }

  # Regra para permitir tráfego na porta 8080
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = var.cidr-remote-access
  }

  tags = {
    Name = "ssh"
  }
}