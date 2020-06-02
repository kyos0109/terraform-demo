variable "eip_count" {
  type        = string
  description = "create eip count"
}

variable "eip_perfix_name" {
  type        = string
  description = "eip perfix name"
}

variable "tags" {
  type        = map
  description = "tags"
  default     = {}
}

variable "availability_zone_list" {
  type        = list(string)
  description = "availability zone"
  default     = []
}

variable "instance_ids" {
  type        = list(string)
  description = "ec2 instance ids"
  default     = []
}