resource "aws_lb_target_group" "backend_target" {
  name         = var.name
  port         = var.backend_port
  protocol     = var.backend_health_check_config.protocol
  vpc_id       = var.vpc_id

  health_check {
    interval            = var.backend_health_check_config.interval
    path                = var.backend_health_check_config.path
    healthy_threshold   = var.backend_health_check_config.healthy_threshold
    unhealthy_threshold = var.backend_health_check_config.unhealthy_threshold
    timeout             = var.backend_health_check_config.timeout
    protocol            = var.backend_health_check_config.protocol
    matcher             = var.backend_health_check_config.matcher
  }

  tags = merge({
    Name     = var.name,
    CreateAt = timestamp()
  },
    var.tags
  )
}

resource "aws_alb" "lb" {
  idle_timeout       = var.loadbalance_config.idle_timeout
  internal           = var.loadbalance_config.internal
  name               = var.name
  load_balancer_type = var.loadbalance_config.load_balancer_type
  security_groups    = var.security_groups_ids
  subnets            = var.subnet_ids

  enable_deletion_protection = var.enable_deletion_protection

  tags = merge({
    Name     = var.name,
    CreateAt = timestamp()
  },
    var.tags
  )

  lifecycle {
    ignore_changes = [
      tags.CreateAt
    ]
  }
}

resource "aws_lb_listener" "frontend" {
  load_balancer_arn = "aws_alb.lb.arn"
  port              = var.frontend_port"
  protocol          = var.frontend_protocol"

  default_action {
    type             = "forward"
    target_group_arn = "aws_lb_target_group.backend_target.arn"
  }
}