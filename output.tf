output "public_subnet" {
  value = module.public_subnets.subnet_array
}

output "private_subnet" {
  value = module.private_subnets.subnet_array
}

output "protection_subnet" {
  value = module.protection_subnets.subnet_array
}

output "nat_gw" {
  value = zipmap(
    aws_nat_gateway.nat_gw.*.tags.Name,
    aws_nat_gateway.nat_gw.*.public_ip,
  )
}

output "jumper_public_ip" {
  value = zipmap(
    module.jumper_eip.this.*.tags.Name,
    module.jumper_eip.this.*.public_ip
  )
}

# output "load_balancer_info" {
#   value = module.demo_alb.lb_info
# }
