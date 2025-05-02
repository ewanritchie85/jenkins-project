terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "ewan-tfstate-bucket"
    key    = "terraform.tfstate"
    region = "eu-west-2"
    encrypt = true
    profile = "ten10"
    
  }
}

provider "aws" {
  region  = var.region
  # profile = var.profile


  default_tags {
    tags = {
      Training = "Platform Engineering Jenkins Project"
    }
  }
}
