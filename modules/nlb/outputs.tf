output "nlb_arn" {
  description = "The ARN of the load balancer"
  value       = element(concat(aws_lb.this.*.arn, [""]), 0)
}

output "nlb_arn_suffix" {
  description = "The ARN suffix for use with CloudWatch Metrics"
  value       = element(concat(aws_lb.this.*.arn_suffix, [""]), 0)
}

output "nlb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = element(concat(aws_lb.this.*.dns_name, [""]), 0)
}

output "nlb_zone_id" {
  description = "The canonical hosted zone ID of the load balancer"
  value       = element(concat(aws_lb.this.*.zone_id, [""]), 0)
}
