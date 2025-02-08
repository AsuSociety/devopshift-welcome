# This resource block creates a custom AWS VPC (Virtual Private Cloud), who named OmerAsus-vpc.
# - `cidr_block`: The CIDR block for the VPC, in our case, it is "10.0.0.0/16"
resource "aws_vpc" "custom_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.vm_name}-vpc"
  }

  lifecycle {
    create_before_destroy = true
    prevent_destroy       = false # Set to true in production
  }
}

# Creates a public subnet within a custom VPC who named OmerAsus-public-subnet.
#   count                   - Number of subnets to create, in our case, it is 2.
#   vpc_id                  - The ID of the VPC where the subnet will be created, obtained from the custom VPC resource.
#   cidr_block              - The CIDR block for the subnet, calculated using the `cidrsubnet` function with the VPC CIDR, a subnet mask of 8, and the current index.
#   map_public_ip_on_launch - Boolean flag to indicate whether to assign a public IP address to instances launched in this subnet. 
resource "aws_subnet" "public_subnet" {
  count                   = var.subnet_count
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone       = random_shuffle.random_az.result[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vm_name}-public-subnet-${count.index}"
  }
  lifecycle {
    create_before_destroy = true
    ignore_changes        = [tags]
  }

  depends_on = [aws_vpc.custom_vpc]
}

# Creates a private subnet within a custom VPC who named OmerAsus-private-subnet.
#   count: The number of subnets to create, in our case, it is 2.
#   vpc_id: The ID of the VPC where the subnet will be created, obtained from the custom VPC resource.
#   cidr_block: The CIDR block for the subnet, calculated using the `cidrsubnet` function with the VPC CIDR, a subnet mask of 8, and an index offset of 10.
resource "aws_subnet" "private_subnet" {
  count             = var.subnet_count
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index + 10)
  availability_zone = random_shuffle.random_az.result[count.index]

  tags = {
    Name = "${var.vm_name}-private-subnet-${count.index}"
  }
  lifecycle {
    create_before_destroy = true
    ignore_changes        = [tags]
  }

  depends_on = [aws_vpc.custom_vpc]
}

# This resource block creates an AWS Internet Gateway who named OmerAsus-igw.
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "${var.vm_name}-igw"
  }
  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_vpc.custom_vpc]
}

# Creates a public route table for the specified VPC who named OmerAsus-public-rt.
#   cidr_block: The CIDR block for the route. In this case, it allows all IPv4 addresses (0.0.0.0/0).
#   gateway_id: The ID of the internet gateway to be used for the route.
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.vm_name}-public-rt"
  }
  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_internet_gateway.igw]
}

# Creates a private route table for the specified VPC who named OmerAsus-private-rt.
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "${var.vm_name}-private-rt"
  }
  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_vpc.custom_vpc]
}

# Associates a route table with public subnets.
# This resource creates an association between the specified route table and each public subnet.
# The number of associations created is determined by the `subnet_count` variable, which is set to 2.
resource "aws_route_table_association" "public_rt_assoc" {
  count          = var.subnet_count
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_rt.id

}

# Shuffle the availability zones to ensure each subnet is in a different AZ
resource "random_shuffle" "random_az" {
  input        = var.az_list
  result_count = var.subnet_count
}


data "aws_subnet" "default" {
  filter {
    name   = "default-for-az"
    values = ["true"]
  }
  filter {
    name   = "availability-zone"
    values = [random_shuffle.random_az.result[0]]
  }
}
