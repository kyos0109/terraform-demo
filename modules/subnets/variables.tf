variable "vpc_id" {
  type        = string
  description = "vpc id"
}

variable "filter_rule" {
  type    = map
  default = {}
}