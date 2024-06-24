terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.54.1"
    }
  }
backend "s3" {
    bucket = "new-robo"
    key    = "eksctl"
    region = "us-east-1"
    dynamodb_table = "roboshop-tab"
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}