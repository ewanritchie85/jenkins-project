terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "ewan-tfstate-bucket"
    key    = "terraform/terraform.tfstate"
    region = var.region
  }
}

provider "aws" {
  region  = var.region
  profile = var.profile

  default_tags {
    tags = {
      Training = "Platform Engineering 1"
    }
  }
}
