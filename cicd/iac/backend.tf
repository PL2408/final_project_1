provider "aws" {
  region = "eu-central-1"
  default_tags {
    tags = {
      Environment = "DEV"
      Project     = "Final project 01"
    }
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.48"
    }
  }
  backend "s3" {
    bucket         = "lopihara"
    key            = "terraform_final_project_1_state"
    region         = "eu-central-1"
    dynamodb_table = "terraform_state"
  }
}
