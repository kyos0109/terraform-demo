variable "name" {
  type = string
}

variable "description" {
  type        = string
  description = "describe"
}

variable "vpc_id" {
  type        = string
  description = "vpc id"
}

variable "tags" {
  type        = map
  description = "tags"
  default     = {}
}