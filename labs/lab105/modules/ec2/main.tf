provider "aws" {
  region = var.region
}

variable "region" {
  default = "us-east-1"
}

variable "ami" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance"
  type        = string
}

variable "security_group_name" {
  description = "Name of the security group"
  type        = string
}
variable "machine_name" {
  description = "Name of the machine"
  type        = string
}

variable "openports" {
}

resource "aws_security_group" "sg" {
  name = var.security_group_name

  dynamic "ingress" {
    for_each = var.openports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "vm" {
  ami           = var.ami
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.sg.id]

  tags = {
    Name = var.machine_name
  }
}

output "vm_public_ip" {
  value       = aws_instance.vm.public_ip
  description = "Public IP address of the VM"
}

output "ami_used" {
  value       = var.ami
  description = "AMI used for the instance"
}

output "aws_region" {
  value       = var.region
  description = "AWS region in use"
}

output "aws_openports" {
  value = var.openports
}



resource "null_resource" "check_public_ip" {
  provisioner "local-exec" {
    command = <<EOT
     if [ -z "${aws_instance.vm.public_ip}" ]; then
       echo "ERROR: Public IP address was not assigned." >&2
       exit 1
       else
       echo "We got the IP! ${aws_instance.vm.public_ip}"
     fi
   EOT
  }


  depends_on = [aws_instance.vm]
}
