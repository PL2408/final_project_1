terraform {
  backend "s3" {
    bucket         = "lopihara"
    key            = "terraform_final_project_1_state"
    region         = "eu-central-1"
    dynamodb_table = "terraform_state"
  }
}