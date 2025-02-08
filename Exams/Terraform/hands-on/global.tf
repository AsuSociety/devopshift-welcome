# VARIABLES
// AWS Region
variable "region" {
  default     = "us-east-1"
  description = "AWS Region"
}

// AMI: Ubuntu 22.04
variable "ami" {
  default = "ami-0e1bed4f06a3b463d"
}

// instance name
variable "vm_name" {
  default = "OmerAsus"
}

// CIDR block for the public subnet
variable "public_subnet" {
  default = "10.0.1.0/24"
}

// CIDR block for the private subnet
variable "private_subnet" {
  default = "10.0.2.0/24"
}

// High availability setting
variable "openports" {
  type    = list(number)
  default = [22, 80]
}

// CIDR block for the VPC
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

// EC2 instance type
variable "instance_type" {
  description = "The instance type for the EC2 instance, for example t2.micro"
  #   default = "t2.micro"
}

// Whether to assign a public IP to the instance
variable "public_ip" {
  default = true
}

// PROVIDER
provider "aws" {
  region = var.region
}

// the amount of subnets to create
variable "subnet_count" {
  description = "Number of subnets to create, needs more than 1 for the alb"
  type        = number
  #   default     = 2
}

variable "az_list" {
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}


variable "min_size" {
  description = "The minimum size of the Auto Scaling group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "The maximum size of the Auto Scaling group"
  type        = number
  default     = 3
}

variable "desired_capacity" {
  description = "The desired capacity of the Auto Scaling group"
  type        = number
  default     = 1
}
