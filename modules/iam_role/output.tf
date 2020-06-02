output "role_name" {
  value = aws_iam_role.this.name
}

output "ssm_instance_profile" {
  value = aws_iam_instance_profile.ec2_ssm.name
}