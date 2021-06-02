
# Configure the AWS provider
provider "aws" {
    region = "ap-south-1"
}

# Create a VPC
resource "aws_vpc" "terra-vpc" {
  cidr_block = var.tf_vpc
  tags = {
    "Name" = "Terra_VPC"
  }
}

# VPC data source
data "aws_vpc" "Terra" {
  tags = {
    "Name" = "Terra_VPC"
  }
}

# Create a Internet Gateway
resource "aws_internet_gateway" "terra-igw" {
  vpc_id = data.aws_vpc.Terra.id
  tags = {
    "Name" = "Terra_IGW"
  }
}

# Create a Public Subnet1
resource "aws_subnet" "terra-subnet1" {
  vpc_id = data.aws_vpc.Terra.id
  cidr_block = var.subnet1_cidr
  availability_zone = var.subnet1_az
  map_public_ip_on_launch = true
  tags = {
    "Name" = "Terra_Subnet1"
  }
}

# Create a Private Subnet2
resource "aws_subnet" "terra-subnet2" {
  vpc_id = aws_vpc.terra-vpc.id
  cidr_block = var.subnet2_cidr
  availability_zone = var.subnet2_az
  map_public_ip_on_launch = false
  tags = {
    "Name" = "Terra_Subnet2"
  }
}

# Creating Route Table
resource "aws_route_table" "terra-rt" {
  vpc_id = aws_vpc.terra-vpc.id
  route {
    cidr_block = var.route_table_cidr
    gateway_id = aws_internet_gateway.terra-igw.id
  }
  tags = {
    "Name" = "Terra-RT"
  } 
}

# Associate Route Table to subnet1
resource "aws_route_table_association" "terra-rt-ass1" {
  route_table_id = aws_route_table.terra-rt.id
  subnet_id = aws_subnet.terra-subnet1.id
}

# Associate Route Table to subnet2
resource "aws_route_table_association" "terra-rt-ass2" {
  route_table_id = aws_route_table.terra-rt.id
  subnet_id = aws_subnet.terra-subnet2.id
}

# Create an EC2 instance

data "aws_ami" "ubuntu" {
  owners = [ "133615223499" ]
}

# Subnet data source
data "aws_subnet" "public" {
  id = aws_subnet.terra-subnet1.id

  tags = {
    "Name" = "Terra_Subnet1"
  }  
}

# Create an EC2 instance resource 
resource "aws_instance" "Terra-EC2" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = "AamirAWSKey"
  subnet_id = data.aws_subnet.public.id
  tags = {
    "Name" = "Terra-EC2"
  }
}

output "aws_sub" {
  value = data.aws_subnet.public.id
}