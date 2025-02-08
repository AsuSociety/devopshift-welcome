output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_lb.alb.dns_name
}
# This output variable exports the ID of the AWS security group created in this module.
output "alb_security_group_id" {
  value = aws_security_group.alb_sg.id
}
