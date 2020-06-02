# get ami id
data "aws_ami" "ec2_image" {
  most_recent = true
  owners      = var.owners

  filter {
    name   = "name"
    values = var.filter_name
  }
  filter {
    name   = "root-device-type"
    values = var.root_device_type
  }
  filter {
    name   = "virtualization-type"
    values = var.virtualization_type
  }
}