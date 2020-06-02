output "this" {
  value = aws_instance.ec2_instance
}

output "id" {
  value = aws_instance.ec2_instance.*.id
}
