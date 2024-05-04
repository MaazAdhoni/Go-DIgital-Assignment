provider "aws" {
  region = "us-east-1" # Change to your desired region
}

resource "aws_ecr_repository" "my_repository" {
  name = "my-repository"
}


