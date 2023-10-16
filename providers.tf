terraform {
  # cloud {
  #   organization = "mexuscloud"
  #   workspaces {
  #     name = "Terra-house-1"
  #   }
  # }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.20.0"
    }
  }
}

provider "aws" {
  # Configuration options
}

provider "random" {
  # Configuration options
}