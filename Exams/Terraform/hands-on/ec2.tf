# This file is used to create an EC2 instance

module "ec2" {
  source = "./modules/ec2"

  ami           = var.ami
  instance_type = var.instance_type
  vm_name       = var.vm_name
  public_ip     = var.public_ip
  openports     = var.openports
}
