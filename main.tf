terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  #backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "ExamPro"

  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
  #cloud {
  #  organization = "ExamPro"
  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}

}

provider "terratowns" {
  endpoint = "https://terratowns.cloud/api"
  user_uuid="4e49974d-c81d-4463-97e6-a4f553052bc9" 
  token="836fe77e-9a50-43d1-94a2-86dc1f5cc599"
}

#module "terrahouse_aws" {
#  source = "./modules/terrahouse_aws"
#  user_uuid = var.user_uuid
#  bucket_name = var.bucket_name
#  index_html_filepath = var.index_html_filepath
#  error_html_filepath = var.error_html_filepath
#  content_version = var.content_version
#}

resource "terratowns_home" "home"{
  name = "People of Palestine!"
  description = <<DESCRIPTION
  The Palestinan people are a people of honor and endurance. They have been under occupation for over 75 years!
  They continue to resist their occupier and push for a FREE PALESTINE!
  DESCRIPTION
  #domain_name =module.terrahouse_aws.cloudfront_url
  domain_name = "234sdf.cloudfront.net"
  town = "missingo"
  content_version = 1
}