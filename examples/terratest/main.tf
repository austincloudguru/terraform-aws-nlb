provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {
}

module "vpc" {
  source             = "terraform-aws-modules/vpc/aws"
  name               = "terratest-vpc"
  cidr               = "10.0.0.0/16"
  azs                = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]
  private_subnets    = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets     = ["10.0.101.0/24", "10.0.102.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Owner       = "mark"
    Environment = "terratest"
  }
}

module "nlb-eip" {
  source         = "../../modules/nlb"
  name           = "terratest-eip"
  subnet_mapping = module.vpc.public_subnets
  enable_eip     = true
  internal       = false
}

module "nlb-noeip" {
  source         = "../../modules/nlb"
  name           = "terratest-noeip"
  subnet_mapping = module.vpc.private_subnets
  enable_eip     = true
}

module "nlb-eip-listener" {
  source            = "../../modules/nlb-listener"
  name              = "terratest-eip-tg"
  load_balancer_arn = module.nlb-eip.nlb_arn
  protocol          = "TCP"
  port              = "443"
  vpc_id            = module.vpc.vpc_id
}

module "nlb-noeip-listener" {
  source            = "../../modules/nlb-listener"
  name              = "terratest-noeip-tg"
  load_balancer_arn = module.nlb-noeip.nlb_arn
  protocol          = "TCP"
  port              = "443"
  vpc_id            = module.vpc.vpc_id
}

module "alb" {
  source                     = "AustinCloudGuru/alb/aws//modules/alb"
  version                    = "1.4.3"
  name                       = "terratest-alb"
  vpc_id                     = module.vpc.vpc_id
  subnets                    = module.vpc.private_subnets
  internal                   = true
  enable_deletion_protection = false
  idle_timeout               = 60
}

module "nlb-alb-lambda" {
  source        = "../../modules/nlb-alb-lambda"
  name          = "terratest"
  alb_dns_name  = module.alb.alb_dns_name
  aws_region    = var.region
  nlb_tg_arn    = module.nlb-eip-listener.nlb_target_group_arn
  protocol      = "HTTPS"
  vpc_id        = module.vpc.vpc_id
  force_destroy = true
}
