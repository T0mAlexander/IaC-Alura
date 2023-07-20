terraform {
  cloud {
    organization = "tom-devops-labs"
    hostname     = "app.terraform.io"

    workspaces {
      tags = ["ansible-terraform"]
    }
  }
}