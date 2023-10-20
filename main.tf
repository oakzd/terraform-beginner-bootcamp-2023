terraform {
#  backend "remote" {
#    hostname = "app.terraform.io"
#    organization = "Terraform-Bootcamp-Zaid"
#
#    workspaces {
#      name = "terra-house-1"
#    }
#  }
# cloud {
#    organization = "Terraform-Bootcamp-Zaid"
#
#    workspaces {
#      name = "terra-house-1"
#    }
#  }
}

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name= var.bucket_name
}
