variable "name" {
  type        = string
  description = "load balance name"
}

variable "vpc_id" {
  type        = string
  description = "vpc id"
}

variable "backend_port" {
  type        = string
  description = backend listen port
  default     = 80
}

variable "frontend_port" {
  type        = string
  description = "frontend listen port"
  default     = 80
}

variable "frontend_protocol" {
  type        = string
  description = "frontend listen protocol"
  default     = "HTTP"
}

variable "tags" {
  type        = map
  description = "tags"
  default     = {}
}

variable "backend_health_check_config" {
  type        = map
  description = "backend health_check config"
  default     = {}
}

variable "enable_deletion_protection" {
  type        = string
  description = "enable deletion protection"
  default     = "false"
}

variable "loadbalance_config" {
  type        = map
  description = "loadbalance config"
  default     = {}
}

variable "security_groups_ids" {
  type        = list(string)
  description = "security groups ids"
  default     = []
}

variable "subnet_ids" {
  type        = list(string)
  description = "subnet ids"
  default     = []
}