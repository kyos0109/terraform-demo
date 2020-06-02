variable "vpc_cidr_block" {
  type    = string
  default = "10.99.0.0/16"
}

variable "subnet_newbits" {
  type    = string
  default = 8
}

variable "enable_deletion_protection" {
  type        = string
  description = "enable deletion protection"
  default     = "false"
}

variable "vpc_tag_name" {
  type        = string
  description = "main vpc"
  default     = "main"
}

variable "jumper_tag_name" {
  type        = string
  description = "ssh jumper name"
  default     = "jumper"
}

variable "public_subnet_name_prefix" {
  type        = string
  description = "private subnet name tag prefix"
  default     = "public-lan"
}

variable "private_subnet_name_prefix" {
  type        = string
  description = "private subnet name tag prefix"
  default     = "private-lan"
}

variable "protection_subnet_name_prefix" {
  type        = string
  description = "protection subnet name tag prefix"
  default     = "protection-lan"
}

variable "nat_gw_eip_perfix_name" {
  type        = string
  description = "eip perfix name"
  default     = "nat-gw"
}

variable "demo_tags" {
  type        = map(string)
  description = "your tags"

  default = {
    Demo = "happy"
  }
}

variable "ec2_instance_map" {
  type        = map(string)
  description = "happy it"

  default = {
    instance_type         = "t3.micro"
    hdd_root_index        = 0
    hdd_size_gb           = 10
    hdd_type              = "gp2"
    delete_on_termination = "true"
  }
}

variable "ssh_public_key_path" {
  type        = string
  description = "ssh public key path"
  default     = "~/.ssh/"
}

variable "ssh_public_key_name" {
  type        = string
  description = "public key name"
  default     = "aws-happy.pub"
}

variable "backend_health_check_config" {
  type        = map(string)
  description = "backend health_check config"

  default = {
    protocol            = "HTTP"
    interval            = 30
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    matcher             = "200"
    path                = "/"
  }
}

variable "loadbalance_config" {
  type        = map(string)
  description = "loadbalance config"

  default = {
    idle_timeout       = 60
    internal           = false
    load_balancer_type = "application"
  }
}

variable "lb_backend_port" {
  type        = string
  description = "backend listen port"
  default     = 80
}

variable "lb_frontend_port" {
  type        = string
  description = "frontend listen port"
  default     = 80
}

variable "auto_scaling_target_cpu_usage" {
  type    = string
  default = 50
}

variable "auto_scaling_desired_capacity" {
  type    = string
  default = 1
}

variable "auto_scaling_ec2s" {
  type = map(string)

  default = {
    max_size = 4
    min_size = 1
  }
}

variable "launch_template_version" {
  type    = string
  default = "$Default"
}

variable "trust_list_acl" {
  type    = list(string)
  default = [
    "220.133.245.131/32",
    "175.181.33.141/32"
  ]
}