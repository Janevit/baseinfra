locals {
  ecr_repo = toset([
  "orbix-blogs-v2",
  "account-deletion-api",
  "ainu",
  "amlo",
  "kk-receiver-api",
  "liveness-activity-api",
  "onboard-api",
  "payplus",
  "orbix-trading-engine",
  "orbix-account-deletion",
  "orbix-admin-api",
  "orbix-api",
  "orbix-api-campaign",
  "orbix-api-kiatnakin",
  "orbix-api-kycv2",
  "orbix-api-reset-password",
  "orbix-api-verification-code",
  "orbix-authnz",
  "orbix-authnz-cron",
  "orbix-authnz-worker",
  "orbix-binance-api",
  "orbix-binance-exporter",
  "orbix-cobo-api",
  "orbix-cobo-exporter",
  "orbix-coin-rate-api",
  "orbix-consent",
  "orbix-daily-invoice",
  "orbix-encryption-key",
  "orbix-enterprise",
  "orbix-invoice-generator",
  "orbix-kplus-authen",
  "orbix-kryptozen-api",
  "orbix-kryptozen-web",
  "orbix-kyc-automation",
  "orbix-login",
  "orbix-ndid-api",
  "orbix-notification-api",
  "orbix-notification-notifier",
  "orbix-pnl-api",
  "orbix-price-alert",
  "orbix-pusher-server",
  "orbix-sec-generator",
  "orbix-trading-engine",
  "tdax-auths-api",
  "thb-exporter",
  "wallet-management-ui",
  "web-portfolio-ui",
  "web-orbix-admin-v2",
  "web-orbix-admin.com",
  "web-orbix-pro-v2.com",
  "web-orbix-pro.com",
  "web-orbixcorp-root",
  "orbix-point",
  "orbix-rebalancer",
  "orbix-api-sec-report",
  "orbix-login-api",
  "orbix-notification-vendor",
  "tdax-auths-api-vendor",
  ])
}

resource "aws_ecr_repository" "ecr_main" {
  for_each = local.ecr_repo
  name     = each.key # note: each.key and each.value are the same for a set

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = var.default_tag
}

############ Output Part ############
output "ecr_uri"{
  description = "URI of the ECR repository"
  value       = [
    for ecr in aws_ecr_repository.ecr_main : ecr.repository_url
  ]
}