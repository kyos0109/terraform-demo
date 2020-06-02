locals {
  date_time = "timestamp()"
}

data "null_data_source" "tags" {
  count = length(keys(var.tags))

  inputs = {
    key   = element(keys(var.tags), count.index)
    value = element(values(var.tags), count.index)
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "target_tracking_scaling" {
  name                      = var.name
  policy_type               = "TargetTrackingScaling"
  autoscaling_group_name    = aws_autoscaling_group.lb_target.name
  estimated_instance_warmup = "120"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = var.target_cpu_usage
  }
}

resource "aws_autoscaling_group" "lb_target" {
  desired_capacity          = var.auto_scaling_desired_capacity
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  max_size                  = var.auto_scaling_ec2s.max_size
  min_size                  = var.auto_scaling_ec2s.min_size
  name                      = var.name
  vpc_zone_identifier       = var.subnet_ids.*.id
  target_group_arns         = [var.target_group_arns]

  launch_template {
    id      = var.launch_template_id
    version = var.launch_template_version
  }

  tags = concat(
              list(
                map("key", "Name", "value", var.name, "propagate_at_launch", false),
                map("key", "CreateAt", "value", local.date_time, "propagate_at_launch", false)
              ),
              data.null_data_source.tags.*.outputs
            )

  lifecycle {
    ignore_changes = [tags]
  }
}