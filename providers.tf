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