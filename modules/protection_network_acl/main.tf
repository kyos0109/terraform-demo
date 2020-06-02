resource "aws_network_acl" "protection_nacl" {
  vpc_id     = var.vpc_id
  subnet_ids = var.protection_subnet_ids

  tags = merge({
      Name     = "default_protection_acl",
      CreateAt = timestamp()
  },
    var.tags
  )
}

resource "aws_network_acl_rule" "default_out_http" {
  network_acl_id = aws_network_acl.protection_nacl.id
  rule_number    = 101
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "default_out_https" {
  network_acl_id = aws_network_acl.protection_nacl.id
  rule_number    = 102
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "default_out_trust" {
  count          = length(var.trust_list_acl)
  network_acl_id = aws_network_acl.protection_nacl.id
  rule_number    = 1100 + count.index
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = var.trust_list_acl[count.index]
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_rule" "default_in_trust" {
  count          = length(var.trust_list_acl)
  network_acl_id = aws_network_acl.protection_nacl.id
  rule_number    = 1000 + count.index
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = var.trust_list_acl[count.index]
  from_port      = 0
  to_port        = 0
}


resource "aws_network_acl_rule" "protection_to_private" {
  count          = length(var.protection_subnet_ids)
  network_acl_id = aws_network_acl.protection_nacl.id
  rule_number    = 901 + count.index
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = element(var.private_subnets_this.*.cidr_block, count.index)
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "private_to_database" {
  count          = length(var.protection_subnet_ids)
  network_acl_id = aws_network_acl.protection_nacl.id
  rule_number    = 201 + count.index
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = element(var.private_subnets_this.*.cidr_block, count.index)
  from_port      = 3306
  to_port        = 3306
}

resource "aws_network_acl_rule" "private_to_redis" {
  count          = length(var.protection_subnet_ids)
  network_acl_id = aws_network_acl.protection_nacl.id
  rule_number    = 301 + count.index
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = element(var.private_subnets_this.*.cidr_block, count.index)
  from_port      = 6379
  to_port        = 6379
}
