resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.visitka_hz.id
  name    = ""
  type    = "A"

  alias {
    name                   = aws_lb.fp01_alb.dns_name
    zone_id                = aws_lb.fp01_alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "validation_cert" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.visitka_hz.zone_id
}

# private hosted zone
resource "aws_route53_zone" "mp_priv_hz" {
  name = "mp"
  vpc {
    vpc_id = aws_vpc.fp01_vpc.id
  }
}

resource "aws_route53_record" "agent_dns" {
  name    = "agent.mp"
  zone_id = aws_route53_zone.mp_priv_hz.id
  type    = "A"
  ttl     = 300
  records = [aws_instance.jenkins_agent.private_ip]
}


resource "aws_route53_record" "web_dns" {
  name    = "web.mp"
  zone_id = aws_route53_zone.mp_priv_hz.id
  type    = "A"
  ttl     = 300
  records = [aws_instance.web_server.private_ip]
}