variable "name" {
  description = "The name of the LB"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "internal" {
  description = "If true, the LB will be internal"
  type        = bool
  default     = true
}

variable "enable_deletion_protection" {
  description = "If true, deletion of the load balancer will be disabled via the AWS API"
  type        = bool
  default     = false
}

variable "subnet_mapping" {
  description = "A list of subnet IDs to attach to the LB"
  type        = list(string)
  default     = []
}

variable "access_logs" {
  description = "An Access Logs block"
  type = list(object({
    bucket  = string
    prefix  = string
    enabled = number
  }))
  default = []
}

variable "enable_cross_zone_load_balancing" {
  description = "If true, deletion of the load balancer will be disabled via the AWS API."
  type        = string
  default     = false
}

variable "enable_eip" {
  description = "If true, allocate elastic IPs.  Internal must also be set to false."
  type        = bool
  default     = false
}
