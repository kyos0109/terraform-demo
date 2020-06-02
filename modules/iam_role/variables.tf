variable "name" {
  type = string
}

variable "description" {
  type        = string
  description = "describe"
}

variable "role_path" {
  description = "Path of IAM role"
  type        = string
  default     = "/"
}

variable "tags" {
  type        = map
  description = "input your tags"
  default     = {}
}
