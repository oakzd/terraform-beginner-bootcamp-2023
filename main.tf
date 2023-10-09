terraform {
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

  cloud {
    organization = "Terraform-Bootcamp-Zaid"

    workspaces {
      name = "terra-house-1"
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
# Providers above

# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
# Resources below
resource "random_string" "bucket_name" {
  lower = true
  upper = false
  length   = 32
  special  = false
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "example" {
  # Bucket Naming Rules
  # https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html
  bucket = random_string.bucket_name.result

}

#Resources above

output "random_bucket_name" {
  value = random_string.bucket_name.result
}

