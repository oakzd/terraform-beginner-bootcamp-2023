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
  cloud {
    organization = "Terraform-Bootcamp-Zaid"
    workspaces {
      name = "terra-house-1"
    }
  }

}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid= var.teacherseat_user_uuid
  token= var.terratowns_access_token
}

module "home_palestine_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.palestine.public_path
  content_version = var.palestine.content_version
  }
resource "terratowns_home" "home"{
  name = "People of Palestine!"
  description = <<DESCRIPTION
  The Palestinan people are a people of honor and endurance. They have been under occupation for over 75 years!
  They continue to resist their occupier and push for a FREE PALESTINE!
  DESCRIPTION
  domain_name = module.home_palestine_hosting.domain_name
  town = "missingo"
  content_version = var.palestine.content_version
}

module "home_pokemon_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.pokemon.public_path
  content_version = var.pokemon.content_version
}

resource "terratowns_home" "home_pokemon"{
  name = "Pokemon!"
  description = <<DESCRIPTION
  I really love pokemon. I play the video games and collect the cards!
  DESCRIPTION
  domain_name =module.home_pokemon_hosting.domain_name
  town = "gamers-grotto"
  content_version = var.pokemon.content_version
}