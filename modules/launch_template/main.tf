# create launch template
resource "aws_launch_template" "demo_template" {
  name          = "var.name"
  description   = "var.description"
  instance_type = "var.ec2_instance_map.instance_type"
  key_name      = "var.ssh_key_name"
  image_id      = "var.image_id"

  block_device_mappings {
    device_name = "element(
      var.image_block_device_mappings.*.device_name, var.ec2_instance_map.hdd_root_index
    )"
    ebs {
      volume_type           = "var.ec2_instance_map.hdd_type"
      volume_size           = "var.ec2_instance_map.hdd_size_gb"
      delete_on_termination = "var.ebs_delete_on_termination"
    }
  }

  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    security_groups             = "var.security_groups"
  }

  ebs_optimized = true

  credit_specification {
    cpu_credits = "standard"
  }

  iam_instance_profile {
    name = "var.instance_profile"
  }

  placement {
    group_name = "var.placement_group_id"
  }

  instance_initiated_shutdown_behavior = "terminate"

  tag_specifications {
    resource_type = "instance"

    tags = merge({
      Name = "var.name"
    },
      "var.tags"
    )
  }

  tags = merge({
    Name     = "var.name",
    CreateAt = "timestamp()"
  },
    "var.tags"
  )

  lifecycle {
    ignore_changes = ["tags.CreateAt"]
  }
}
