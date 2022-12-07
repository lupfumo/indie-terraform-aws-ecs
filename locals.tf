locals {
  name        = "${var.business_division}-${var.local-environment}"
  environment = var.local-environment
  region      = var.aws_region
  owners      = var.business_division
  common_tags = {
    owners      = local.owners
    environment = local.environment
  }
}
