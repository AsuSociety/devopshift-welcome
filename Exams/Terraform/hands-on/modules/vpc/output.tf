
output "vpc_id" {
  value = aws_vpc.custom_vpc.id
}

output "public_subnet_ids" {
  value = [for subnet in aws_subnet.public_subnet : subnet.id]
}

output "private_subnet_ids" {
  value = [for subnet in aws_subnet.private_subnet : subnet.id]
}

output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}

output "public_route_table_id" {
  value = aws_route_table.public_rt.id
}

output "private_route_table_id" {
  value = aws_route_table.private_rt.id
}

output "public_route_table_association_ids" {
  value = [for assoc in aws_route_table_association.public_rt_assoc : assoc.id]
}

output "public_subnet_cidr_blocks" {
  value = [for subnet in aws_subnet.public_subnet : subnet.cidr_block]
}

output "private_subnet_cidr_blocks" {
  value = [for subnet in aws_subnet.private_subnet : subnet.cidr_block]
}

output "public_subnet_azs" {
  value = [for i in range(var.subnet_count) : aws_subnet.public_subnet[i].availability_zone]
}

output "private_subnet_azs" {
  value = [for i in range(var.subnet_count) : aws_subnet.private_subnet[i].availability_zone]
}
