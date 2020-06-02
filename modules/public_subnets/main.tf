# create public subnet
resource "aws_subnet" "public_subnet_zone" {
  count             = length(var.availability_zone_list)
  vpc_id            = var.vpc_id
  availability_zone = element(var.availability_zone_names, count.index)
  cidr_block        = cidrsubnet(var.cidr_block_default, var.subnet_newbits, count.index)

  tags = merge({
      Name     = format("%s-%s", var.tag_name_prefix, element(var.availability_zone_list.*.name_suffix, count.index)),
      AZ       = element(var.availability_zone_names, count.index),
      CreateAt = timestamp()
  },
    var.tags
  )

  lifecycle {
    ignore_changes = [
      tags["CreateAt"],
    ]
  }
}