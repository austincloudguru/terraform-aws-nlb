resource "aws_eip" "these" {
  #checkov:skip=CKV2_AWS_19: "Ensure that all EIP addresses allocated to a VPC are attached to EC2 instances"
  count = var.enable_eip && !var.internal ? length(var.subnet_mapping) : 0
  tags  = merge({ "Name" = var.name }, var.tags)
}

resource "aws_lb" "this" {
  #checkov:skip=CKV_AWS_152: "Ensure that Load Balancer (Network/Gateway) has cross-zone load balancing enabled"
  #checkov:skip=CKV_AWS_150: "Ensure that Load Balancer has deletion protection enabled"
  #checkov:skip=CKV_AWS_131: "Ensure that ALB drops HTTP headers"
  #checkov:skip=CKV_AWS_103: "Ensure that load balancer is using at least TLS 1.2"
  #checkov:skip=CKV2_AWS_28: "Ensure public facing ALB are protected by WAF"
  name                             = var.name
  internal                         = var.internal
  load_balancer_type               = "network"
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing
  enable_deletion_protection       = var.enable_deletion_protection
  tags = merge(
    {
      "Name" = var.name
    },
    var.tags
  )

  dynamic "subnet_mapping" {
    #for_each = range(length(var.subnet_mapping))
    for_each = [for i in range(length(var.subnet_mapping)) : {
      subnet_id     = var.subnet_mapping[i]
      allocation_id = var.enable_eip && !var.internal ? aws_eip.these[i].id : null
    }]
    content {
      subnet_id     = subnet_mapping.value.subnet_id
      allocation_id = subnet_mapping.value.allocation_id
    }
  }

  dynamic "access_logs" {
    for_each = var.access_logs
    content {
      bucket  = lookup(access_logs.value, "bucket", null)
      prefix  = lookup(access_logs.value, "prefix", null)
      enabled = lookup(access_logs.value, "true", null)
    }
  }
}
