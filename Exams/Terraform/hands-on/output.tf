output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "The ID of the public subnet"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "The ID of the private subnet"
  value       = module.vpc.private_subnet_ids
}

output "internet_gateway_id" {
  description = "The ID of the internet gateway"
  value       = module.vpc.internet_gateway_id
}

output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = module.vpc.public_route_table_id
}

output "private_route_table_id" {
  description = "The ID of the private route table"
  value       = module.vpc.private_route_table_id
}

output "public_route_table_association_ids" {
  description = "The ID of the public route table association"
  value       = module.vpc.public_route_table_association_ids
}

output "public_subnet_cidr_blocks" {
  description = "CIDR blocks of the public subnets"
  value       = module.vpc.public_subnet_cidr_blocks
}

output "private_subnet_cidr_blocks" {
  description = "CIDR blocks of the private subnets"
  value       = module.vpc.private_subnet_cidr_blocks
}

output "public_subnet_azs" {
  description = "Availability zones of the public subnets"
  value       = module.vpc.public_subnet_azs
}

output "private_subnet_azs" {
  description = "Availability zones of the private subnets"
  value       = module.vpc.private_subnet_azs
}

output "ec2_instance_public_ips" {
  description = "The public IP addresses of the EC2 instances"
  value       = module.ec2.ec2_instance_public_ips
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = module.ec2.security_group_id
}

output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = module.alb.alb_dns_name
}


output "alb_security_group_id" {
  description = "The ID of the security group"
  value       = module.alb.alb_security_group_id
}
