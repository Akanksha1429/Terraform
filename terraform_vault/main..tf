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
  region = "us-east-1"
}

provider "vault" {
  address = "http://54.87.112.170:8200"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id = "05dba451-3434-812f-b674-130b6797b1b0"
      secret_id = "91a21a55-5863-c5e4-3ff9-18f3ce3a67f6"
    }
  }
}

data "vault_kv_secret_v2" "secret" {
  mount = "kv"
  name  = "test-secret"
}

resource "aws_instance" "ec2_instance" {
  ami = "ami-04b70fa74e45c3917"
  instance_type = "t2.micro"

  tags = {
    Name = "test-vault-secret"
    Secret = data.vault_kv_secret_v2.secret.data["username"]
  }
}
