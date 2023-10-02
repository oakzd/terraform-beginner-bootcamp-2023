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
}

# Providers below
provider "aws" {
  # Configuration options
}

provider "random" {
  # Configuration options
}
# Providers above

# Resources below
resource "random_string" "bucket_name" {
  length   = 16
  special  = false
}

resource "aws_s3_bucket" "example" {
  bucket = random_string.bucket_name.result
}

#Resources above

output "random_bucket_name" {
  value = random_string.bucket_name.result
}

