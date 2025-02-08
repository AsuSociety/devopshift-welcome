
# This resource block defines an AWS EC2 instance who named OmerAsus-ec2.
# - ami: The ID of the AMI to use for the instance, in our case, it is Ubuntu 22.04.
# - instance_type: The type of instance to start in our case, it is t2.micro.
# - associate_public_ip_address: Boolean to associate a public IP address with the instance.
# - vpc_security_group_ids: A list of security group IDs to associate with the instance, in our case, it is the security group we created(OmerAsus-ec2-sg).
resource "aws_instance" "ec2" {
  ami                         = var.ami
  instance_type               = var.instance_type
  associate_public_ip_address = var.public_ip
  vpc_security_group_ids      = [aws_security_group.sg.id]
  tags = {
    Name = "${var.vm_name}-ec2"
  }

  #   lifecycle {
  #     ignore_changes = [tags]
  #   }
}

# Creates an AWS Security Group with the specified name and rules, who named OmerAsus-ec2-sg.
# Dynamic Ingress Rules:
# Use the openports variable to create dynamic ingress rules for the security group.
# Egress Rule:
# Allow all traffic to leave the instance.
resource "aws_security_group" "sg" {
  name = "${var.vm_name}-ec2-sg"

  dynamic "ingress" {
    for_each = var.openports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

