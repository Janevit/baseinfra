#Account Shareinfra (singapore)
resource "aws_acm_certificate" "shareinfra_singapore_main_cert" {
    provider          = aws.ShareInfra
    private_key       = file(var.ACM_private_key_shareinfra)
    certificate_body  = file(var.ACM_cert_body_shareinfra)
    certificate_chain = file(var.ACM_cert_chain_shareinfra)
    lifecycle {
        create_before_destroy = true
    }
    tags              = var.default_tag
}

#Account Shareinfra (Virginia)
resource "aws_acm_certificate" "shareinfra_virginia_main_cert" {
  provider          = aws.ShareInfra-virginia
  private_key       = file(var.ACM_private_key_shareinfra)
  certificate_body  = file(var.ACM_cert_body_shareinfra)
  certificate_chain = file(var.ACM_cert_chain_shareinfra)
  lifecycle {
        create_before_destroy = true
  }
  tags              = var.default_tag
}

########### Output Part ############
output "Certificate_ShareInfra_Singapore_Arn"{
  description = "ACM Certificate (ShareInfra-Singapore Account) Arn"
  value       = try(aws_acm_certificate.shareinfra_singapore_main_cert.arn, "")
}

output "Certificate_ShareInfra_Virginia_Arn"{
  description = "ACM Certificate (ShareInfra-Virginia Account) Arn"
  value       = try(aws_acm_certificate.shareinfra_virginia_main_cert.arn, "")
}
