terraform {
#  backend "remote" {
#    hostname = "app.terraform.io"
#    organization = "Terraform-Bootcamp-Zaid"
#
#    workspaces {
#      name = "terra-house-1"
#    }
#  }
#
# cloud {
#    organization = "Terraform-Bootcamp-Zaid"
#
#    workspaces {
#      name = "terra-house-1"
#    }
#  }
required_providers {
    random = {
     source = "hashicorp/random"
      version = "3.5.1"
    }
      aws = {
      source = "hashicorp/aws"
      version = "5.19.0"
    }
  }
}

# Providers below
provider "aws" {
  # Configuration options
}

provider "random" {
  # Configuration options
}