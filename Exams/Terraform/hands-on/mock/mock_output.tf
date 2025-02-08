// Mocking VPC and Subnet Configuration
# Mock the VPC ID
output "mock_vpc_id" {
  value       = "vpc-12345678"
  description = "Mocked VPC ID for testing purposes."
}

# Mock the number of subnets (High availability logic)
output "mock_subnet_count" {
  value       = var.high_availability ? 3 : 1
  description = "Number of subnets required based on high availability setting."
}

# Mocking subnet names for testing
locals {
  mock_subnets = var.high_availability ? ["subnet-a", "subnet-b", "subnet-c"] : ["subnet-a"]
}

output "mock_subnet_names" {
  value       = [for subnet in local.mock_subnets : "Mocked ${subnet}"]
  description = "A mocked list of subnet names for testing."
}

# Mocking Internet Gateway ID
output "mock_igw_id" {
  value       = "igw-87654321"
  description = "Mocked Internet Gateway ID for testing."
}

# Mock Route Table Configuration
output "mock_route_table" {
  value       = var.environment == "prod" ? "Full Routing Enabled" : "Limited Routing Enabled"
  description = "Mocked route table configuration based on environment."
}

// Mocking ec2 instance public IPs
# Mock EC2 Instance ID
output "mock_ec2_instance_id" {
  value       = "i-1234567890abcdef0"
  description = "Mocked EC2 instance ID for testing."
}

# Mock EC2 Instance Type
output "mock_ec2_instance_type" {
  value       = var.vm_size
  description = "Mocked EC2 instance type."
}

# Mock EC2 Public IP
output "mock_ec2_public_ip" {
  value       = var.environment == "prod" ? "54.123.45.67" : "192.168.1.100"
  description = "Mocked EC2 public IP based on environment."
}

# Mock Security Group ID
output "mock_security_group_id" {
  value       = "sg-0987654321abcdef0"
  description = "Mocked Security Group ID for testing."
}

# Mocking open ports based on user input
output "mock_open_ports" {
  value       = [for port in var.openports : "Port ${port} is open"]
  description = "A mocked list of open ports based on security group rules."
}
