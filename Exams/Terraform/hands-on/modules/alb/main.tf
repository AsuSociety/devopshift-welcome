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

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

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
