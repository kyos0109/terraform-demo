output "ids_list" {
  value = local.subnet_ids_list
}

output "ids" {
  value = data.aws_subnet_ids.all_subnet.ids
}