#Account Nonprod (singapore)
resource "aws_acm_certificate" "nonprod_singapore_main_cert" {
    private_key       = file(var.ACM_private_key)
    certificate_body  = file(var.ACM_cert_body)
    certificate_chain = file(var.ACM_cert_chain)
    lifecycle {
        create_before_destroy = true
    }
    tags              = var.default_tag
}

########### Output Part ############
output "Certificate_Nonprod_Singapore_Arn"{
  description = "ACM Certificate (Nonprod-Singapore Account) Arn"
  value       = try(aws_acm_certificate.nonprod_singapore_main_cert.arn, "")
}