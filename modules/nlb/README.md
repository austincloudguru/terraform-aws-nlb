# nlb
This module creates an NLB.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.8.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.these](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_lb.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_logs"></a> [access\_logs](#input\_access\_logs) | An Access Logs block | <pre>list(object({<br>    bucket  = string<br>    prefix  = string<br>    enabled = number<br>  }))</pre> | `[]` | no |
| <a name="input_enable_cross_zone_load_balancing"></a> [enable\_cross\_zone\_load\_balancing](#input\_enable\_cross\_zone\_load\_balancing) | If true, deletion of the load balancer will be disabled via the AWS API. | `string` | `false` | no |
| <a name="input_enable_deletion_protection"></a> [enable\_deletion\_protection](#input\_enable\_deletion\_protection) | If true, deletion of the load balancer will be disabled via the AWS API | `bool` | `false` | no |
| <a name="input_enable_eip"></a> [enable\_eip](#input\_enable\_eip) | If true, allocate elastic IPs.  Internal must also be set to false. | `bool` | `false` | no |
| <a name="input_internal"></a> [internal](#input\_internal) | If true, the LB will be internal | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the LB | `string` | `""` | no |
| <a name="input_subnet_mapping"></a> [subnet\_mapping](#input\_subnet\_mapping) | A list of subnet IDs to attach to the LB | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nlb_arn"></a> [nlb\_arn](#output\_nlb\_arn) | The ARN of the load balancer |
| <a name="output_nlb_arn_suffix"></a> [nlb\_arn\_suffix](#output\_nlb\_arn\_suffix) | The ARN suffix for use with CloudWatch Metrics |
| <a name="output_nlb_dns_name"></a> [nlb\_dns\_name](#output\_nlb\_dns\_name) | The DNS name of the load balancer |
| <a name="output_nlb_zone_id"></a> [nlb\_zone\_id](#output\_nlb\_zone\_id) | The canonical hosted zone ID of the load balancer |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
