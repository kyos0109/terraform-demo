resource "aws_iam_role" "this" {
  name               = var.name
  description        = var.description
  path               = var.role_path

  assume_role_policy   = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

  tags = merge({
    Name     = var.name,
    CreateAt = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
  },
    var.tags
  )
}

resource "aws_iam_role_policy_attachment" "EC2RoleforSSM" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
  role       = aws_iam_role.this.name
}

resource "aws_iam_instance_profile" "ec2_ssm" {
  name = "ec2_ssm"
  role = aws_iam_role.this.name
}