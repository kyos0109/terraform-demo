# create ec2 instance
resource "aws_instance" "ec2_instance" {
  count         = var.ssh_jumper_count
  ami           = var.image_id
  instance_type = var.ec2_instance_map.instance_type
  key_name      = var.ssh_key_name
  subnet_id     = var.subnet_ids[count.index]

  vpc_security_group_ids = var.security_groups_ids

  root_block_device {
    volume_type           = var.ec2_instance_map.hdd_type
    volume_size           = var.ec2_instance_map.hdd_size_gb
    delete_on_termination = var.ec2_instance_map.delete_on_termination
  }

  tags = merge({
    Name        = format("%s-%s", var.tag_name, var.subnet_ids[count.index]),
    CreateAt    = timestamp(),
    Description = var.description
  },
    var.tags
  )

  lifecycle {
    ignore_changes = [tags.CreateAt]
  }
}