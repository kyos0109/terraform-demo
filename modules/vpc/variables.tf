variable "tags" {
  type        = map
  description = "tags"
  default     = {}
}

variable "tag_name" {
  type = string
}

variable "cidr_block" {
  type = string
}