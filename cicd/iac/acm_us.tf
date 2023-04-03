resource "aws_acm_certificate" "cert_us" {
  domain_name       = "lopihara.iplatinum.pro"
  validation_method = "DNS"
  provider          = aws.virginia

  tags = {
    Environment = "test"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "validation_cert_us" {
  provider                = aws.virginia
  certificate_arn         = aws_acm_certificate.cert_us.arn
  validation_record_fqdns = [for record in aws_route53_record.validation_cert : record.fqdn]
}