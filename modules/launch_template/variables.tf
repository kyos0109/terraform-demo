variable "name" {
  type        = "string"
  description = "name"
}

variable "description" {
  type        = "string"
  description = "describe"
}

variable "ec2_instance_map" {
  type        = "map"
  description = "ec2 instance info"
  default     = {}
}

variable "ssh_key_name" {
  type        = "string"
  description = "ssh public key name"
}

variable "image_id" {
  type        = "string"
  description = "ami images id"
}

variable "security_groups" {
  type        = list(string)
  description = "security groups list"
  default     = []
}

variable "ebs_delete_on_termination" {
  type        = "string"
  description = "when ec2 termination, ebs termination policy"
  default     = true
}

variable "image_block_device_mappings" {
  type        = list(string)
  description = "input module ami"
  default     = []
}

variable "instance_profile" {
  type        = "string"
  description = "instance profile from iam role"
  default     = ""
}

variable "placement_group_id" {
  type        = "string"
  description = "placement group id"
}

variable "tags" {
  type        = "map"
  description = "tags"
  default     = {}
}