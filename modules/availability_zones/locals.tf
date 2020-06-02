locals {
  zone_ids_string = join(",", data.aws_availability_zones.available.names)
  zone_ids_list   = split(",", local.zone_ids_string)
}