output "subnet_array" {
  value = zipmap(
    aws_subnet.public_subnet_zone.*.id, aws_subnet.public_subnet_zone.*.cidr_block
  )
}

output "this" {
  value = aws_subnet.public_subnet_zone
}

output "ids" {
  value = aws_subnet.public_subnet_zone.*.id
}