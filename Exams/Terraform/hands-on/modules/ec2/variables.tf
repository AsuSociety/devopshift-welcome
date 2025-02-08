variable "ami" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
}

variable "vm_name" {
  description = "The name of the VM"
  type        = string
}

variable "public_ip" {
  description = "Whether to assign a public IP to the instance"
  type        = bool
}

variable "openports" {
  description = "List of ports to open for the security group"
  type        = list(number)
}

