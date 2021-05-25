
# Configure the AWS provider
provider "aws" {
    region = "ap-south-1"
}

# Create a VPC
resource "aws_vpc" "terraform-vpc" {
  cidr_block = "10.2.0.0/16"
  tags = {
    "name" = "Terrafrom_VPC"
  }
}
