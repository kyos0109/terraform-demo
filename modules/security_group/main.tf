# create security group
resource "aws_security_group" "allow_demo" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = ["pl-64a5400d", "pl-c9b451a0"] # s3 and dynamodb in ap-southeast-1
  }

  tags = merge({
    Name = var.name,
    CreateAt = timestamp()
  },
    var.tags
  )

  lifecycle {
    ignore_changes = [tags.CreateAt]
  }
}