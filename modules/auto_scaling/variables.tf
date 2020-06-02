variable "name" {
  type = string
}

variable "target_cpu_usage" {
  type    = string
  default = 50.0
}

variable "auto_scaling_desired_capacity" {
  type = string
}

variable "health_check_grace_period" {
  type    = string
  default = 300
}

variable "health_check_type" {
  type    = string
  default = "ELB"
}

variable "auto_scaling_ec2s" {
  type = map

  default = {
    max_size = 2
    min_size = 1
  }
}

variable "subnet_ids" {
  type    = list(string)
  default = []
}

variable "target_group_arns" {
  type = string
}

variable "launch_template_id" {
  type = string
}

variable "launch_template_version" {
  type    = string
  default = "$Default"
}

variable "tags" {
  type    = map
  default = {}
}