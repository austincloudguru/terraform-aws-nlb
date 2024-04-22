#------------------------------------------------------------------------------
# Create an S3 Bucket for Tracking public access
#------------------------------------------------------------------------------
resource "aws_s3_bucket" "this" {
  #checkov:skip=CKV2_AWS_62: "Ensure S3 buckets should have event notifications enabled"
  #checkov:skip=CKV_AWS_18: "Ensure the S3 bucket has access logging enabled"
  #checkov:skip=CKV2_AWS_61: "Ensure that an S3 bucket has a lifecycle configuration"
  #checkov:skip=CKV_AWS_145: "Ensure that S3 buckets are encrypted with KMS by default"
  #checkov:skip=CKV_AWS_144: "Ensure that S3 bucket has cross-region replication enabled"
  #checkov:skip=CKV_AWS_21: "Ensure all data stored in the S3 bucket have versioning enabled"
  bucket        = join("-", [var.name, "alb-tg-bucket"])
  force_destroy = var.force_destroy
  lifecycle {
    prevent_destroy = false
  }
  tags = {
    Name = join("-", [var.name, "alb-tg-bucket"])
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

#------------------------------------------------------------------------------
# Create an Instance Profile
#------------------------------------------------------------------------------
resource "aws_iam_instance_profile" "lambda_profile" {
  name = join("-", [var.name, "nlb-alb-lambda-instance-profile"])
  role = aws_iam_role.lambda_role.name
}

resource "aws_iam_role" "lambda_role" {
  name               = join("-", [var.name, "nlb-alb-lambda-role"])
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

resource "aws_iam_role_policy" "lambda_role_policy" {
  name   = join("-", [var.name, "lambda-alb-as-target"])
  role   = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.lambda_policy.json
}

data "aws_iam_policy_document" "lambda_policy" {
  #checkov:skip=CKV_AWS_108: "Ensure IAM policies does not allow data exfiltration"
  #checkov:skip=CKV_AWS_111: "Ensure IAM policies does not allow write access without constraints"
  #checkov:skip=CKV_AWS_356: "Ensure no IAM policies documents allow "*" as a statement's resource for restrictable actions"
  statement {
    sid    = "LambdaLogging"
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:*:*:*"]
  }
  statement {
    sid    = "S3"
    effect = "Allow"
    actions = [
      "s3:Get*",
      "s3:PutObject",
      "s3:CreateBucket",
      "s3:ListBucket",
      "s3:ListAllMyBuckets"
    ]
    resources = ["*"]
  }
  statement {
    sid    = "ELB"
    effect = "Allow"
    actions = [
      "elasticloadbalancing:Describe*",
      "elasticloadbalancing:RegisterTargets",
      "elasticloadbalancing:DeregisterTargets"
    ]
    resources = ["*"]
  }
  statement {
    sid       = "CW"
    effect    = "Allow"
    actions   = ["cloudwatch:putMetricData"]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

#------------------------------------------------------------------------------
# Deploy ALB Lambda Function
#------------------------------------------------------------------------------
resource "aws_cloudwatch_event_rule" "every_minute" {
  name                = "every-minute"
  description         = "Fires every minute"
  schedule_expression = "rate(1 minute)"
}

resource "aws_cloudwatch_event_target" "check_nlb_alb" {
  arn  = aws_lambda_function.nlb_alb.arn
  rule = aws_cloudwatch_event_rule.every_minute.name
}

resource "aws_lambda_permission" "cloudwatch_check_nlb_alb" {
  statement_id  = "AllowWExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.nlb_alb.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.every_minute.arn
}

resource "aws_lambda_function" "nlb_alb" {
  #checkov:skip=CKV_AWS_50: "X-Ray tracing is enabled for Lambda"
  #checkov:skip=CKV_AWS_117: "Ensure that AWS Lambda function is configured inside a VPC"
  #checkov:skip=CKV_AWS_116: "Ensure that AWS Lambda function is configured for a Dead Letter Queue(DLQ)"
  #checkov:skip=CKV_AWS_173: "Check encryption settings for Lambda environmental variable"
  #checkov:skip=CKV_AWS_272: "Ensure AWS Lambda function is configured to validate code-signing"
  #checkov:skip=CKV_AWS_115: "Ensure that AWS Lambda function is configured for function-level concurrent execution limit"
  depends_on    = [aws_s3_bucket.this]
  function_name = join("-", [var.name, "nlb-alb-tg"])
  description   = join(" ", ["NLB to ALB for", var.name])
  s3_bucket     = join("-", ["exampleloadbalancer", var.aws_region])
  s3_key        = var.region_lambda_function
  handler       = "populate_NLB_TG_with_ALB.lambda_handler"
  role          = aws_iam_role.lambda_role.arn
  runtime       = "python3.8"
  timeout       = 300

  environment {
    variables = {
      ALB_DNS_NAME                      = var.alb_dns_name
      NLB_TG_ARN                        = var.nlb_tg_arn
      S3_BUCKET                         = aws_s3_bucket.this.bucket
      MAX_LOOKUP_PER_INVOCATION         = var.max_lookup_per_invocation
      INVOCATIONS_BEFORE_DEREGISTRATION = var.invocations_before_deregistration
      CW_METRIC_FLAG_IP_COUNT           = var.cw_metric_flag_ip_count
      ALB_LISTENER                      = var.alb_listener
    }
  }

}
