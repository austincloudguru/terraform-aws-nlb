variable "name" {
  description = "The name of the LB"
  type        = string
  default     = ""
}

variable "port" {
  description = "The port on which targets receive traffic, unless overridden when registering a specific target"
  type        = string
  default     = 80
}

variable "protocol" {
  description = "The protocol to use for routing traffic to the targets"
  type        = string
  default     = "HTTP"
}

variable "vpc_id" {
  description = "The identifier of the VPC in which to create the target group"
  type        = string
}

variable "load_balancer_arn" {
  description = "The ARN of the of the load balancer"
  type        = string
}

variable "target_type" {
  description = "Type of target that you must specify when registering targets with this target group."
  type        = string
  default     = "ip"
}

variable "deregistration_delay" {
  description = "Amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused."
  type        = number
  default     = 300
}

variable "health_check" {
  description = "Listener Rule Health Check"
  type = list(object({
    interval            = number
    path                = string
    timeout             = number
    healthy_threshold   = number
    unhealthy_threshold = number
    port                = number
    protocol            = string
    enabled             = bool
  }))
  default = [{
    interval            = 30
    path                = null
    timeout             = null
    healthy_threshold   = 2
    unhealthy_threshold = 2
    port                = 443
    protocol            = "TCP"
    enabled             = true
  }]
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
