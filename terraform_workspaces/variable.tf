# Describe the variables block
variable "ami" {
    description = "value for the AMI being used"
    type = string
}

variable "instance_type" {
    description = "value for the instance-type of the AWS instance to be created"
    type = string
}