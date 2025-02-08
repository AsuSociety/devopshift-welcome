# This output variable provides the public IP addresses of all EC2 instances created in this module.
output "ec2_instance_public_ips" {
  value = aws_instance.ec2[*].public_ip
}

# This output variable exports the ID of the AWS security group created in this module.
output "security_group_id" {
  value = aws_security_group.sg.id
}
