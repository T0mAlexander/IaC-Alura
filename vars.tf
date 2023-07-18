variable "default-region" {
  default = "sa-east-1"
}
variable "default-zone" {
  default = "sa-east-1a"
}

variable "ssh-key" {
  default = "ansible-terraform"
}

variable "cidr-remote-access" {
  type = list(string)

  default = ["0.0.0.0/0"]
}