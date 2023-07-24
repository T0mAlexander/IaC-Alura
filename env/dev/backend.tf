terraform {
  backend "s3" {
    bucket = "curso-iac-infra-state"
    key    = "dev/terraform.tfstate"
    region = "sa-east-1"
  }
}
