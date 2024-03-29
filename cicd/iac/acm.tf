resource "aws_acm_certificate" "cert" {
  domain_name       = "devopsik.iturbo.click"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "validation_cert" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.validation_cert : record.fqdn]
}