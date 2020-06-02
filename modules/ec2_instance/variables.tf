variable "ec2_instance_map" {
  type        = map
  description = "happy it"

  default = {
    delete_on_termination = "true"
  }
}

variable "tag_name" {
  type = string
}

variable "ssh_jumper_count" {
  type = string
  description = "ssh jumper count"
}

variable "description" {
  type        = string
  description = "describe"
}

variable "ssh_key_name" {
  type        = string
  description = "ssh public key name"
}

variable "image_id" {
  type        = string
  description = "ami images id"
}

variable "security_groups_ids" {
  type        = list(string)
  description = "security groups list"
  default     = []
}

variable "tags" {
  type        = map
  description = "tags"
  default     = {}
}

variable "subnet_ids" {
  type        = list(string)
  description = "subnet ids"
  default     = []
}

variable "instance_profile" {
  type        = string
  description = "instance profile from iam role"
  default     = ""
}