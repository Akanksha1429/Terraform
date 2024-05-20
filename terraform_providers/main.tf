# Describe the key pair to be used.
resource "aws_key_pair" "public_key" {
  key_name = var.key_name
  public_key = file("~/.ssh/id_rsa.pub")
}

# Describe the vpc to be used.
resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr
}

# Describe the subnet 
resource "aws_subnet" "subnet1" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = var.cidr_block
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
}

#Describe the internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
}

#Describe the route table
resource "aws_route_table" "RT" {
    vpc_id = aws_vpc.myvpc.id 

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }  
}

#Describe the route table association
resource "aws_route_table_association" "rta1" {
    subnet_id = aws_subnet.subnet1.id
    route_table_id = aws_route_table.RT.id
}

#Describe the security group
resource "aws_security_group" "webSg" {
    name = "web"
    vpc_id = aws_vpc.myvpc.id

    ingress {
        description = "HTTP from VPC"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    } 
    tags = {
      Name = "Web-sg"
    }
}

#Describe the aws instance
resource "aws_instance" "server" {
    ami = var.ami_value
    instance_type = var.instance_type
    key_name = aws_key_pair.public_key.key_name
    vpc_security_group_ids = [aws_security_group.webSg.id]
    subnet_id = aws_subnet.subnet1.id

    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
      host = self.public_ip
    }

 # File provisioner to copy a file from local to the remote EC2 instance
    provisioner "file" {
        source = "app.py"
        destination = "/home/ubuntu/app.py"
     }
    
    provisioner "remote-exec" {
        inline = [ 
            "echo 'Hello from the remote instance'",
            "sudo apt update -y",
            "sudo apt-get install -y python3-pip",
            "cd /home/ubuntu",
            "sudo apt install python3-flask", #"sudo pip3 install flask"
            "sudo python3 app.py &",
         ]
     }

     tags = {
       Name = "app_demo"
     }
}








