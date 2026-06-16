
provider "aws" {
  region  = "eu-west-2"
}

resource "aws_ecr_repository" "ecr_repo" {
  name = "chris-tf-repo"

  tags = {
    owner = "chris-ce"
  }
}

