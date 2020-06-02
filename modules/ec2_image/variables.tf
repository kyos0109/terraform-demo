variable "owners" {
  type        = list(string)
  default     = []
  description = "image owners"
}

variable "filter_name" {
  type        = list(string)
  default     = []
  description = "this image name"
}

# variable "name" {
#   type        = list(string)
#   default     = []
#   description = "filter image name"
# }

variable "root_device_type" {
  type        = list(string)
  default     = ["ebs"]
  description = "filter image root device type"
}

variable "virtualization_type" {
  type        = list(string)
  default     = ["hvm"]
  description = "filter image virtualization type"
}