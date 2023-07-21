variable "regiao" {
  type = string
}

variable "america-do-sul" {
  type = string
  default = "sa-east-1"
}

variable "sao-paulo" {
  type = string
  default = "sa-east-1a"
}

variable "chave" {
  type = string
}

variable "chave-ssh" {
  type = string
  default = "ansible-terraform"
}

variable "grupo_seg" {
  type = string
}

variable "cidr-remote-access" {
  type = list(string)
  default = ["0.0.0.0/0"]
}

variable "ubuntu" {
  type = string
  default = "ami-0af6e9042ea5a4e3e"
}

variable "tipo_da_instancia" {
  type = string
}

variable "free-tier" {
  type = string
  default = "t2.micro"
}

variable "autoscale_min" {
  type = number
}

variable "autoscale_max" {
  type = number
}
