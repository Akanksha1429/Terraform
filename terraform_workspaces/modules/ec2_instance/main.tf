# Create an EC2 instance
resource "aws_instance" "first_instance" {
    ami = var.ami
    instance_type = var.instance_type

    tags = {
      Name = "terraform_demo"
    }
}