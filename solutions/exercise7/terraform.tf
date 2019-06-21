terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "chris-testing"

    workspaces {
      name = "hashicorp-training"
    }
  }
}
