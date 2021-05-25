
# Configure the AWS provider
provider "aws" {
    region = "ap-south-1"
}

# Defining variables
variable "tf_vpc" {
  default = "10.2.0.0/16"
}

# Create a VPC
resource "aws_vpc" "terraform-vpc" {
  cidr_block = var.tf_vpc
  tags = {
    "Name" = "Terrafrom_VPC"
  }
}

# Create a Internet Gateway
resource "aws_internet_gateway" "terraform-igw" {
    vpc_id = aws_vpc.terraform-vpc.id
    tags = {
      "Name" = "Terraform_IGW"
    }
}