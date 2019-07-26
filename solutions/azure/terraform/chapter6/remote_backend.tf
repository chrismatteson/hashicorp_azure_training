terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "mattesonchristest"
    workspaces {
      name = "newtest"
    }
  }
}

