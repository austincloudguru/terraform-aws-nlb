# AWS Network Load Balancer Module
A set of Terraform modules for working with an AWS Network Load Balancer (NLB).

# Usage
## nlb
Create a Network Load Balancer
```hcl
module "nlb" {
  source                           = "AustinCloudGuru/nlb/aws//module/nlb"
  # You should pin the module to a specific version
  #version                          = "X.X.X"
  name                             = "external-nlb"
  subnet_mapping                   = ["subnet-00000000000000000", "subnet-11111111111111111", "subnet-22222222222222222"]
  enable_eip                       = true
  internal                         = false
  enable_deletion_protection       = true
  enable_cross_zone_load_balancing = true
}
```

## nlb-listener
Create a listener for an NLB.
```hcl
module "nlb-eip-listener" {
  source            = "AustinCloudGuru/nlb/aws//module/nlb-listener"
  # You should pin the module to a specific version
  #version           = "X.X.X"
  name              = "external-nlb-tg"
  load_balancer_arn = module.nlb.nlb_arn
  protocol          = "TCP"
  port              = "443"
  vpc_id            = "vpc-11111111111111111"
}
```

## nlb-alb-lambda
Creates a Lambda job that will update an NLB listener target group with the IP addresses of an ALB.  This module is based on [this post](https://aws.amazon.com/blogs/networking-and-content-delivery/using-static-ip-addresses-for-application-load-balancers/) and uses the AWS provided lambda
```hcl
module "nlb-alb-lambda" {
  source        = "AustinCloudGuru/nlb/aws//module/nlb-alb-lambda"
  # You should pin the module to a specific version
  #version       = "X.X.X"
  source        = "../../modules/nlb-alb-lambda"
  name	        = "external-nlb"
  alb_dns_name	= "internal-alb-613746554.us-east-1.elb.amazonaws.com"
  aws_region    = "us-east-1"
  nlb_tg_arn  	= module.nlb-eip-listener.nlb_target_group_arn
  protocol      = "HTTPS"
  vpc_id        = "vpc-11111111111111111"
  force_destroy = true
}
```

## Authors
Module is maintained by [Mark Honomichl](https://github.com/austincloudguru).

## License
MIT Licensed.  See LICENSE for full details
