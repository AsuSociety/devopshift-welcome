provider "aws" {
 region = var.region
}

variable "region" {
 default = "us-east-1"
}

data "aws_ami" "my-ami-id"{
    owners = ["self"]
    filter {
      name = "name"
      values = ["terraform-workshop-image-do-not-delete"]
    }
}

# variable "ami" {
#  default = "ami-0a5b3d67a84b13bf9"
#  }
variable "vm_name" {
 default = "vm-OmerAsus"
}

variable "admin_username" {
 default = "admin-user"
}

variable "admin_password" {
 default = "Password123!"
}

variable "vm_size" {
 default = "t2.micro"
}
