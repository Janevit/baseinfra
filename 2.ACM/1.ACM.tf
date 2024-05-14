resource "aws_acm_certificate" "Amazon_issued_certificate_1" {
  domain_name       = var.Amazon_issued_certificate_1
  validation_method = "DNS"
  key_algorithm     = "RSA_2048"
  tags              = var.default_tag
  lifecycle {
    create_before_destroy = true
  }
}

############ Output Part ############
output "Certificate_Amazon_issued_certificate_1_Arn"{
  description = "ACM Certificate Arn"
  value       = try(aws_acm_certificate.Amazon_issued_certificate_1.arn, "")
}
