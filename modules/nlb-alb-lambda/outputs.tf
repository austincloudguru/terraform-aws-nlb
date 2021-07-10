output "s3_bucket_arn" {
  description = "The ARN of the bucket."
  value       = element(concat(aws_s3_bucket.this.*.arn, [""]), 0)
}
