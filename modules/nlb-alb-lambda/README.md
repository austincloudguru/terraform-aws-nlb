# nlb-alb-lambda
Deploys a lambda that will upgrade a target group with the IP addresses for an Application Load Balancer (ALB).

This is used primarily to allow static IP Addresses for ALBs.

https://aws.amazon.com/blogs/networking-and-content-delivery/using-static-ip-addresses-for-application-load-balancers/

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14, < 1.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~>3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~>3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.every_minute](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.check_nlb_alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_iam_instance_profile.lambda_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.lambda_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.lambda_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_lambda_function.nlb_alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.cloudwatch_check_nlb_alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_iam_policy_document.lambda_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_dns_name"></a> [alb\_dns\_name](#input\_alb\_dns\_name) | The full DNS name (FQDN) of the ALB | `string` | n/a | yes |
| <a name="input_alb_listener"></a> [alb\_listener](#input\_alb\_listener) | The traffic listener port of the ALB | `number` | `443` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region to work in | `string` | `"us-east-1"` | no |
| <a name="input_cw_metric_flag_ip_count"></a> [cw\_metric\_flag\_ip\_count](#input\_cw\_metric\_flag\_ip\_count) | The controller flag that enables the CloudWatch metric of the IP address count. | `bool` | `true` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. | `bool` | `false` | no |
| <a name="input_invocations_before_deregistration"></a> [invocations\_before\_deregistration](#input\_invocations\_before\_deregistration) | Then number of required Invocations before an IP address is deregistered. | `number` | `3` | no |
| <a name="input_max_lookup_per_invocation"></a> [max\_lookup\_per\_invocation](#input\_max\_lookup\_per\_invocation) | The max times of DNS look per invocation. | `number` | `50` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the LB | `string` | `""` | no |
| <a name="input_nlb_tg_arn"></a> [nlb\_tg\_arn](#input\_nlb\_tg\_arn) | The ARN of the NLBs target group | `string` | n/a | yes |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | The protocol to use for routing traffic to the targets | `string` | `"HTTP"` | no |
| <a name="input_region_lambda_function"></a> [region\_lambda\_function](#input\_region\_lambda\_function) | n/a | `string` | `"blog-posts/static-ip-for-application-load-balancer/populate_NLB_TG_with_ALB_python3.zip"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The identifier of the VPC in which to create the target group | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_s3_bucket_arn"></a> [s3\_bucket\_arn](#output\_s3\_bucket\_arn) | The ARN of the bucket. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
