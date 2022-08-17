terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.26.0"
    }
  }

}

provider "aws" {
  shared_credentials_file = "~/.aws/credentials"
  profile = "default"
  region  = "ap-south-1"
}
