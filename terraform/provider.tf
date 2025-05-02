provider "aws" {
  region  = var.region
  profile = var.profile

  default_tags {
    tags = {
      Training = "Platform Engineering 1"
    }
  }
}
