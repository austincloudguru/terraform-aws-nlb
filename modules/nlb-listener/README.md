# nlb-listener
This module creates an NLB Listener.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14, < 0.16 |
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
| [aws_lb_listener.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deregistration_delay"></a> [deregistration\_delay](#input\_deregistration\_delay) | Amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused. | `number` | `300` | no |
| <a name="input_health_check"></a> [health\_check](#input\_health\_check) | Listener Rule Health Check | <pre>list(object({<br>    interval            = number<br>    path                = string<br>    timeout             = number<br>    healthy_threshold   = number<br>    unhealthy_threshold = number<br>    port                = number<br>    protocol            = string<br>    enabled             = bool<br>  }))</pre> | <pre>[<br>  {<br>    "enabled": true,<br>    "healthy_threshold": 2,<br>    "interval": 30,<br>    "path": null,<br>    "port": 443,<br>    "protocol": "TCP",<br>    "timeout": null,<br>    "unhealthy_threshold": 2<br>  }<br>]</pre> | no |
| <a name="input_load_balancer_arn"></a> [load\_balancer\_arn](#input\_load\_balancer\_arn) | The ARN of the of the load balancer | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the LB | `string` | `""` | no |
| <a name="input_port"></a> [port](#input\_port) | The port on which targets receive traffic, unless overridden when registering a specific target | `string` | `80` | no |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | The protocol to use for routing traffic to the targets | `string` | `"HTTP"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_target_type"></a> [target\_type](#input\_target\_type) | Type of target that you must specify when registering targets with this target group. | `string` | `"ip"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The identifier of the VPC in which to create the target group | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_listener_arn"></a> [listener\_arn](#output\_listener\_arn) | The ARN of the listener |
| <a name="output_nlb_target_group_arn"></a> [nlb\_target\_group\_arn](#output\_nlb\_target\_group\_arn) | The ARN of the Target Group |
| <a name="output_nlb_target_group_arn_suffix"></a> [nlb\_target\_group\_arn\_suffix](#output\_nlb\_target\_group\_arn\_suffix) | The ARN suffix for use with CloudWatch Metrics |
| <a name="output_nlb_target_group_name"></a> [nlb\_target\_group\_name](#output\_nlb\_target\_group\_name) | The name of the Target Group |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
