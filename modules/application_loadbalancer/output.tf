output "lb_info" {
  value = aws_alb.lb.dns_name
}

output "target_backend_arn" {
  value = aws_lb_target_group.backend_target.arn
}