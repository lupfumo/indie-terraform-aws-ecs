# Configure the AWS Provider
terraform {
  backend "s3" {
    bucket         = "lupfumo-terraform-s3-group" //Bucket name
    key            = "app1/terraform.tfstate"
    region         = "af-south-1"
    dynamodb_table = "aws-terraform-table" //DynamoDB table
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}