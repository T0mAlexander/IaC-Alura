terraform {
  backend "s3" {
    bucket = "curso-iac-infra-state"
    key    = "prod/terraform.tfstate"
    region = "sa-east-1"
  }
}
