variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnet" {
  description = "The CIDR block for the public subnet"
  type        = string
}

variable "private_subnet" {
  description = "The CIDR block for the private subnet"
  type        = string
}

variable "vm_name" {
  description = "The name of the VM"
  type        = string
}

variable "subnet_count" {
  description = "Number of subnets to create"
  type        = number
}

variable "az_list" {
  description = "List of availability zones"
  type        = list(string)

}
