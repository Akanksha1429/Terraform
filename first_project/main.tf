# Configure the provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  alias = "east"
  region = "us-east-1"
}

module "ec2_instance" {
  source = "./EC2-module"
  ami_value = "ami-04b70fa74e45c3917"
  instance_type = "t2.micro"  
}
