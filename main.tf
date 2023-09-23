provider "aws" {
  region = "us-east-1" 
  access_key = ""
  secret_key = ""

}

# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
}

# Create a public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.0.0/24" 
  availability_zone = "us-east-1a" 
  map_public_ip_on_launch = true
}

# Create a private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24" 
  availability_zone = "us-east-1b" 

# Create a security group allowing SSH inbound and all outbound
resource "aws_security_group" "my_sg" {
  name        = "my-sg"
  description = "My Security Group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic 
  }
}

# Create an EC2 instance
resource "aws_instance" "nimesa_assig1" {
  ami           = "ami-0261755bbcb8c4a84" 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = "demoKP-virginia" 
  associate_public_ip_address = true

  root_block_device {
    volume_size = 8
    volume_type = "gp2"
    delete_on_termination = true
  }

  tags = {
    purpose = "Assignment"
  }
}
