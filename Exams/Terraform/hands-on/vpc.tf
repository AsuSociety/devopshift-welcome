# This file is used to create a VPC with public and private subnets.

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr       = var.vpc_cidr
  public_subnet  = var.public_subnet
  private_subnet = var.private_subnet
  vm_name        = var.vm_name
  subnet_count   = var.subnet_count
  az_list        = var.az_list
}
