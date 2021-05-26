# Defining variables
variable "tf_vpc" {
  default = "10.2.0.0/16"
}

variable "subnet1_cidr" {
  default = "10.2.0.0/24"
}

variable "subnet1_az" {
  default = "ap-south-1a"
}

variable "subnet2_cidr" {
  default = "10.2.1.0/24"
}

variable "subnet2_az" {
  default = "ap-south-1b"
}

variable "route_table_cidr" {
  default = "0.0.0.0/0"
}