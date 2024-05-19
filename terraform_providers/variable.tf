# Describe the variables block
variable "key_name" {
  description = "Key_name"
  type = string
}

variable "cidr" {
  description = "value for the CIDR block"
    type = string
}

variable "cidr_block" {
  description = "value for the CIDR block of the subnet"
    type = string
}

variable "ami_value" {
    description = "value for the AMI being used"
    type = string
}

variable "instance_type" {
    description = "value for the instance-type of the AWS instance to be created"
    type = string
}


