variable "high_availability" {
  type        = bool
  default     = false
  description = "Enable high availability mode"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Deployment environment (dev/prod)"
}


// ec2 instance variables
variable "vm_size" {
  type        = string
  default     = "t2.micro"
  description = "Size of the EC2 instance"
}


variable "openports" {
  type        = list(number)
  default     = [22, 80, 443]
  description = "List of ports to open in the security group"
}
