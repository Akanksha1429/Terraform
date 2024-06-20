# Scenario-1 

Q. You already have infrastructure created on the cloud provider(AWS). The team was using Cloud Formation templates to build the infrastucture. An EC2 instance is created using the Cloud Formation Template. Now the management agreed to migrate to Terraform. How will you import the configuration entirely to Terraform?

Ans : Using "terraform import" command.
Following are the steps followed to import the information : 
- Write a main.tf file.
```
provider "aws" {
  region = "us-east-1"
}

import {
  id = "instance_id"
  to = instance_type.instance_name
}
```
### terraform would look into AWS for the instance and copy the entire resource configuration into the resource mentioned in "to" block.

- Next step would be to generate the file.
```
Command : 
terraform init
terraform plan -generate-config-out="generated_resources.tf"
```
### This plan command would create a new tf file that would contain all the configuration." # __generated__ by Terraform  resource "aws_instance" "example" { ami                                  = "ami-04b70fa74e45c3917" associate_public_ip_address          = true            availability_zone                    = "us-east-1c"                 disable_api_stop                     = false .................}"

- Copy the configuration to main file

- After this run the command 
```
terraform plan
```
to check the configurations being correctly copied. Yet the work isn't done as statefile is missing.

- Execute the below command to import the configuration to statefile.
```
terraform import aws_instance.example instance_id
```
The successful execution of the command would result in creation of statefile which is the core heart and soul of terraform.