# create EIP
resource "aws_eip" "eips" {
  count    = var.eip_count
  instance = length(var.instance_ids) > 0 ? element(concat(var.instance_ids, list("")), count.index) : ""
  vpc      = true

  tags = merge({
    Name     = format("%s-%s", var.eip_perfix_name, element(var.availability_zone_list, count.index)),
    CreateAt = timestamp()
  },
    var.tags
  )

  lifecycle {
    prevent_destroy = false
    ignore_changes = [tags.CreateAt]
  }
}
