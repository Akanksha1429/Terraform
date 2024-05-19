terraform {
  backend "s3" {
    bucket = "kumariak-s3-demo"
    region = "us-east-1"
    #key = "kumariak-s3-demo/terraform.tfstate"
    dynamodb_table = "terraform_lock"
  }
}
