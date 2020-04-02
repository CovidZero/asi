terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "covidzero-tc"

    workspaces {
      prefix = "covidzero-"
    }
  }
}