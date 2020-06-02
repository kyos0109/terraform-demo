resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge({
    Name        = var.tag_name,
    CreateAt    = timestamp()
  },
    var.tags
  )
}

# create igw
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge({
    Name        = var.tag_name,
    CreateAt    = timestamp()
  },
    var.tags
  )
}