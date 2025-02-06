module "ec2_instance" {
  source              = "./modules/ec2"
  ami                 = "ami-0c02fb55956c7d316"
  instance_type       = "t2.micro"
  region              = "us-east-1"
  security_group_name = "yaniv-sg"
  machine_name        = "OmerAsus-VM"
  openports           = [22, 80, 433]
}

output "vm_public_ip" {
  value = module.ec2_instance.vm_public_ip
}

output "ami_used" {
  value = module.ec2_instance.ami_used
}

output "aws_region" {
  value = module.ec2_instance.aws_region
}

output "aws_openports" {
  value = module.ec2_instance.aws_openports
}
