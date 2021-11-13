variable "aws_region" {
  description = "The AWS region to work in"
  type        = string
  default     = "us-east-1"
}

variable "name" {
  description = "The name of the LB"
  type        = string
  default     = ""
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

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "region_lambda_function" {
  type    = string
  default = "blog-posts/static-ip-for-application-load-balancer/populate_NLB_TG_with_ALB_python3.zip"
}

variable "alb_dns_name" {
  description = "The full DNS name (FQDN) of the ALB"
  type        = string
}

variable "nlb_tg_arn" {
  description = "The ARN of the NLBs target group"
  type        = string
}

variable "max_lookup_per_invocation" {
  description = "The max times of DNS look per invocation."
  type        = number
  default     = 50
}

variable "invocations_before_deregistration" {
  description = "Then number of required Invocations before an IP address is deregistered. "
  type        = number
  default     = 3
}

variable "cw_metric_flag_ip_count" {
  description = "The controller flag that enables the CloudWatch metric of the IP address count. "
  type        = bool
  default     = true
}

variable "alb_listener" {
  description = "The traffic listener port of the ALB"
  type        = number
  default     = 443
}

variable "force_destroy" {
  description = "A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error."
  type        = bool
  default     = false
}
