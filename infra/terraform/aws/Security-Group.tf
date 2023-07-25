resource "aws_security_group" "tcp-alb" {
  name   = var.nome_repositorio
  vpc_id = module.vpc.vpc_id

  ingress {
    description = "Expondo a porta 8000"
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Trafego de saida"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "privado_ECS" {
  name = "entrada_ECS"
  vpc_id = module.vpc.vpc_id

  ingress {
    description = "Trafego privado de entrada"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Trafego privado de saida"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}