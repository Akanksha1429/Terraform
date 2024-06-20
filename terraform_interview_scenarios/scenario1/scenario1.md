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
### This plan command would create a new tf file that would contain all the configuration.