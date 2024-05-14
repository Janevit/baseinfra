#Account Shareinfra (singapore)
resource "aws_acm_certificate" "Amazon_issued_shareinfra_singapore_main_cert" {
    provider          = aws.ShareInfra
    domain_name       = var.Amazon_issued_certificate_1
    validation_method = "DNS"
    key_algorithm     = "RSA_2048"
    lifecycle {
        create_before_destroy = true
    }
    tags              = var.default_tag
}

#Account Shareinfra (Virginia)
resource "aws_acm_certificate" "Amazon_issued_shareinfra_virginia_main_cert" {
  provider          = aws.ShareInfra-virginia
  domain_name       = var.Amazon_issued_certificate_1
  validation_method = "DNS"
  key_algorithm     = "RSA_2048"
  lifecycle {
    create_before_destroy = true
  }
  tags              = var.default_tag
}


############ Output Part ############
output "Certificate_ShareInfra_Singapore_Arn"{
  description = "ACM Certificate (ShareInfra-Singapore Account) Arn"
  value       = try(aws_acm_certificate.Amazon_issued_shareinfra_singapore_main_cert.arn, "")
}

output "Certificate_Amazon_issued_shareinfra_virginia_main_cert_Arn"{
  description = "ACM Certificate (ShareInfra-Virginia Account) Arn"
  value       = try(aws_acm_certificate.Amazon_issued_shareinfra_virginia_main_cert.arn, "")
}
