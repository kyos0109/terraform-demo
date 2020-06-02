variable "vpc_id" {
  type        = string
  description = "vpc id"
}

variable "availability_zone_names" {
  type        = list(string)
  description = "availability zone"
  default     = []
}

variable "availability_zone_list" {
  type        = list
  description = "availability zone"
  default     = []
}

variable "tag_name_prefix" {
  type        = string
  description = "tag subnet name prefix"
}

variable "cidr_block_default" {
  type        = string
  description = "cidr block default"
}

variable "tags" {
  type        = map
  description = "tags"
  default     = {}
}

variable "subnet_newbits" {
  type    = string
  default = ""
}
