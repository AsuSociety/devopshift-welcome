
        provider "aws" {
        region = "us-east-1"
        }

        data "aws_vpc" "default" {
        default = true
        }

        resource "aws_subnet" "public" {
        count             = 2
        vpc_id            = data.aws_vpc.default.id
        cidr_block        = "172.31.${96 + count.index}.0/24"
        availability_zone = element(["us-east-1a", "us-east-1b"], count.index)
        map_public_ip_on_launch = true
        }

        resource "aws_instance" "web_server" {
        ami           = "ami-010045ee1d3ea738b"
        instance_type = "t3.small"
        availability_zone = "us-east-1a"
        security_groups = [aws_security_group.lb_sg.id]
        subnet_id     = aws_subnet.public[0].id
        tags = {
            Name = "WebServer"
        }
        }

        resource "aws_lb" "application_lb" {
        name               = "OmerAlb"
        internal           = false
        load_balancer_type = "application"
        security_groups    = [aws_security_group.lb_sg.id]
        subnets            = aws_subnet.public[*].id
        }

        resource "aws_security_group" "lb_sg" {
        name        = "lb_sg_OmerAlb_20250221133829"  # Use Jinja2 variables
        description = "Allow HTTP inbound traffic"
        vpc_id      = data.aws_vpc.default.id
        ingress {
            from_port   = 80
            to_port     = 80
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
        
        # Add egress rule to allow all outbound traffic
        egress {
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_blocks = ["0.0.0.0/0"]
        }
        }

        resource "aws_lb_listener" "http_listener" {
        load_balancer_arn = aws_lb.application_lb.arn
        port              = 80
        protocol          = "HTTP"
        default_action {
            type             = "forward"
            target_group_arn = aws_lb_target_group.web_target_group.arn
        }
        }

        resource "aws_lb_target_group" "web_target_group" {
        name     = "web-tg-OmerAlb-20250221133829"  # Added timestamp for uniqueness
        port     = 80
        protocol = "HTTP"
        vpc_id   = data.aws_vpc.default.id
        health_check {
            path                = "/"
            port                = "80"
            protocol            = "HTTP"
            healthy_threshold   = 2
            unhealthy_threshold = 2
            timeout             = 5
            interval            = 10
        }
        }

        resource "aws_lb_target_group_attachment" "web_instance_attachment" {
        target_group_arn = aws_lb_target_group.web_target_group.arn
        target_id        = aws_instance.web_server.id
        }

        output "instance_id" {
        value = aws_instance.web_server.id
        }

        output "lb_dns_name" {
        value = aws_lb.application_lb.dns_name
        }
        