terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92"
    }
  }

  backend "s3" {
    bucket = ""
    key    = ""
    region = ""
  }


  required_version = ">= 1.15"
}
