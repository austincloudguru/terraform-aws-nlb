# AWS Network Load Balancer Module
A set of Terraform modules for working with an AWS Network Load Balancer (NLB).

# Usage
## nlb (With EIP):
```hcl
module "nlb-eip" {
  source                           = "AustinCloudGuru/nlb/aws//module/nlb"
  # Pin every module to a specific version
  #version                          = "X.X.X"
  name                             = "terratest-eip"
  subnet_mapping                   = module.vpc.public_subnets
  enable_eip                       = true
  internal                         = false
  enable_deletion_protection       = true
  enable_cross_zone_load_balancing = true
}
```

## nlb (Without EIP):
```hcl
module "nlb-noeip" {
  source                           = "AustinCloudGuru/nlb/aws//module/nlb"
  # Pin every module to a specific version
  #version                          = "X.X.X"
  name                             = "terratest-eip"
  subnet_mapping                   = module.vpc.public_subnets
  internal                         = false
  enable_deletion_protection       = true
  enable_cross_zone_load_balancing = true
}
```
