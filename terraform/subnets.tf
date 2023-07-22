resource "aws_default_subnet" "subnet_1" {
  availability_zone = var.sao-paulo
}

resource "aws_default_subnet" "subnet_2" {
  availability_zone = var.sao-paulo-c
}