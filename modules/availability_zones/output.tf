output "list" {
  value = data.aws_availability_zone.all_zone_array
}

output "names" {
  value = data.aws_availability_zones.available.names
}

output "name_suffix" {
  value = data.aws_availability_zone.az.*.name_suffix
}