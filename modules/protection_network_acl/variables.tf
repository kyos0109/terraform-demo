variable "vpc_id" {
  type        = string
  description = "vpc id"
}

variable "protection_subnet_this" {
  description = "protection subnet this object"
  default     = {}
}

variable "protection_subnet_ids" {
  type        = list(string)
  description = "protection subnet this object"
  default     = []
}

variable "private_subnets_this" {
  description = "private subnet this object"
  default     = {}
}

variable "trust_list_acl" {
  type    = list(string)
  default = []
}

variable "tags" {
  type        = map
  description = "tags"
  default     = {}
}