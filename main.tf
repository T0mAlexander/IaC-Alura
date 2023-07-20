terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.8.0"
    }
  }
}

provider "aws" {
  region = var.default-region
}

resource "aws_instance" "server" {
  ami           = "ami-0af6e9042ea5a4e3e" # Ubuntu Server 22.04 LTS
  instance_type = "t2.micro"              # Instância do Free Tier da AWS
  key_name      = var.ssh-key

  root_block_device {
    volume_size           = 30
    volume_type           = "gp2"
    delete_on_termination = true
  }

  vpc_security_group_ids = [aws_security_group.ssh-access.id]

  tags = {
    "name" = "Máquina de Desenvolvimento"
  }
}

resource "aws_instance" "prod" {
  ami           = "ami-0af6e9042ea5a4e3e" # Ubuntu Server 22.04 LTS
  instance_type = "t2.micro"              # Instância do Free Tier da AWS
  key_name      = var.ssh-key

  vpc_security_group_ids = [aws_security_group.ssh-access.id]

  tags = {
    "name" = "Máquina de Produção"
  }
}