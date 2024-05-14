resource "aws_cloudfront_origin_access_identity" "ORG_Access" {
  provider    = aws.ShareInfra
  comment = "${var.AppID}-${var.AppName}-${var.Env}-OAI"
}

############ Output Part ############
output "OAI-IAM"{
  description = "iAM of Origin Access Identity"
  value       = aws_cloudfront_origin_access_identity.ORG_Access.iam_arn
}

output "OAI-path"{
  description = "access identity path"
  value       = aws_cloudfront_origin_access_identity.ORG_Access.cloudfront_access_identity_path
}