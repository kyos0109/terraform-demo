output "image_id" {
  description = "The ID of the image"
  value = data.aws_ami.ec2_image.image_id
}

output "block_device_mappings" {
  value = data.aws_ami.ec2_image.block_device_mappings
}

output "this" {
  description = "module this"
  value = data.aws_ami.ec2_image
}