output "listener_arn" {
  description = "The ARN of the listener"
  value       = element(concat(aws_lb_listener.this.*.arn, [""]), 0)
}

output "nlb_target_group_arn" {
  description = "The ARN of the Target Group"
  value       = element(concat(aws_lb_target_group.this.*.arn, [""]), 0)
}

output "nlb_target_group_arn_suffix" {
  description = "The ARN suffix for use with CloudWatch Metrics"
  value       = element(concat(aws_lb_target_group.this.*.arn_suffix, [""]), 0)
}

output "nlb_target_group_name" {
  description = "The name of the Target Group"
  value       = element(concat(aws_lb_target_group.this.*.name, [""]), 0)
}
