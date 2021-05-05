resource "aws_lb_listener" "this" {
  load_balancer_arn = var.load_balancer_arn
  port              = var.port
  protocol          = var.protocol
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_lb_target_group" "this" {
  name                 = var.name
  protocol             = var.protocol
  port                 = var.port
  target_type          = var.target_type
  vpc_id               = var.vpc_id
  deregistration_delay = var.deregistration_delay

  dynamic "health_check" {
    for_each = var.health_check
    content {
      enabled             = lookup(health_check.value, "enabled", null)
      interval            = lookup(health_check.value, "interval", null)
      path                = lookup(health_check.value, "path", null)
      timeout             = lookup(health_check.value, "timeout", null)
      healthy_threshold   = lookup(health_check.value, "healthy_threshold", null)
      unhealthy_threshold = lookup(health_check.value, "unhealthy_threshold", null)
      port                = lookup(health_check.value, "port", null)
      protocol            = lookup(health_check.value, "protocol", null)
    }
  }

  tags = merge(
    {
      "Name" = var.name
    },
    var.tags
  )

}
