# Creates an AWS Application Load Balancer (ALB) resource, who named OmerAsus-alb.
# - internal: Indicates whether the load balancer is internal (false for internet-facing).
# - load_balancer_type: The type of load balancer (application as we asked to).
# - security_groups: A list of security group IDs to associate with the load balancer.
# - subnets: A list of subnet IDs where the load balancer will be deployed, ensuring unique subnets using the `distinct` function.
# - enable_deletion_protection: Whether deletion protection is enabled (false).
resource "aws_lb" "alb" {
  name               = "${var.vm_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = distinct(var.subnet_ids)

  enable_deletion_protection = false

  tags = {
    Name = "${var.vm_name}-alb"
  }
}

# This resource block defines an AWS Load Balancer Target Group, who named OmerAsus-tg.
# - port: The port on which the targets receive traffic (set to 80).
# - protocol: The protocol to use for routing traffic to the targets (set to HTTP).
# - vpc_id: The ID of the VPC in which to create the target group, provided by the `vpc_id` variable.
# 
# The `health_check` block configures health check settings for the target group,
# Did this as we saw in the labs.
resource "aws_lb_target_group" "tg" {
  name     = "${var.vm_name}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${var.vm_name}-tg"
  }
}

# This resource defines an AWS Application Load Balancer (ALB) listener, who named OmerAsus-listener.
# The listener listens for incoming traffic on port 80 using the HTTP protocol.
# It forwards the traffic to the specified target group, also as we saw in the labs.
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

# This resource defines an AWS Auto Scaling Group (ASG), who named OmerAsus-asg, with the following properties:
# - Uses a launch template specified by its ID and the latest version.
# - The minimum, maximum, and desired number of instances are defined by variables as we asked to.
# - Instances are launched in subnets specified by the `subnet_ids` variable, ensuring unique values.
# - Associates the ASG with a target group specified by the ARN of the AWS Load Balancer target group.
resource "aws_autoscaling_group" "asg" {
  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  vpc_zone_identifier = distinct(var.subnet_ids)
  target_group_arns   = [aws_lb_target_group.tg.arn]

  tag {
    key                 = "Name"
    value               = "${var.vm_name}-asg"
    propagate_at_launch = true
  }
}

# This resource block defines an AWS Launch Template, who named OmerAsus-lt.
# - image_id: The AMI ID to use for the instances, provided by the variable `ami`.
# - instance_type: The type of instance to launch, provided by the variable `instance_type`.
resource "aws_launch_template" "lt" {
  name          = "${var.vm_name}-lt"
  image_id      = var.ami
  instance_type = var.instance_type

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.vm_name}-instance"
    }
  }
}

# Creates a security group for the Application Load Balancer (ALB), who named OmerAsus-alb-sg.
# - vpc_id: The ID of the VPC where the security group will be created.
# Ingress Rules:
# - Allows incoming traffic on port 80 (HTTP) from any IP address (0.0.0.0/0).
# Egress Rules:
# - Allows all outbound traffic to any IP address (0.0.0.0/0).
resource "aws_security_group" "alb_sg" {
  name        = "${var.vm_name}-alb-sg"
  description = "Security group for ALB"

  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.vm_name}-alb-sg"
  }
}
