resource "aws_security_group" "ssh_cluster" {
  name   = "ssh-cluster"
  vpc_id = module.vpc.vpc_id

  ingress {
    description = "Trafego de entrada"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
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