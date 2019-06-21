terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "jlinn"

    workspaces {
      name = "hashicorp-training"
    }
  }
}
