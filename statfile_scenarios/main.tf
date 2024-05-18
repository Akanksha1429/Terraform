resource "aws_instance" "trial_server" {
  ami = "ami-04b70fa74e45c3917"
  instance_type = "t2.micro"  
  provider = aws.east
  tags = {
    Name = "backend-trial"
  }
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "kumariak-s3-demo"
}

resource "aws_dynamodb_table" "terraform-lock" {
  name           = "terraform_lock"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockId"
 
  attribute {
    name = "LockId"
    type = "S"
  }
}
