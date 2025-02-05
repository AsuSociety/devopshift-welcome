provider "aws" {
  region = var.region
}

variable "region" {
  default = "us-east-1"
}


data "aws_instance" "example" {
  # with the id
  instance_id = "i-09df7e0ed385f871b"

  # with the tag name
  # filter {
  #   name = "tag:Name"
  #   values = ["yaniv-vm"]
  # }

}

output "aws_yaniv_vm_public_ip" {
  value = data.aws_instance.example.public_ip
}