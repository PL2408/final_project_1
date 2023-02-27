# dns record to alb - dynamic web page
resource "aws_route53_record" "www" {
  zone_id         = data.aws_route53_zone.visitka_hz.id
  name            = ""
  type            = "A"
  health_check_id = aws_route53_health_check.dynamic_page_health_check.id
  set_identifier  = "primary"

  alias {
    name                   = aws_lb.fp01_alb.dns_name
    zone_id                = aws_lb.fp01_alb.zone_id
    evaluate_target_health = true
  }

  failover_routing_policy {
    type = "PRIMARY"
  }
}

# dns to s3 static page
resource "aws_route53_record" "www_sp" {
  zone_id        = data.aws_route53_zone.visitka_hz.id
  name           = ""
  type           = "A"
  set_identifier = "secondary"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }

  failover_routing_policy {
    type = "SECONDARY"
  }
}

resource "aws_route53_health_check" "dynamic_page_health_check" {
  fqdn              = aws_lb.fp01_alb.dns_name
  port              = 443
  type              = "HTTPS"
  resource_path     = "/"
  failure_threshold = "1"
  request_interval  = "30"

  tags = {
    Name = "dynamic_page_health_check"
  }
}

# certificate validation
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

# private dns for agent
resource "aws_route53_record" "agent_dns" {
  name    = "agent.mp"
  zone_id = aws_route53_zone.mp_priv_hz.id
  type    = "A"
  ttl     = 300
  records = [aws_instance.jenkins_agent.private_ip]
}
  
# private dns for web-server
resource "aws_route53_record" "web_dns" {
  name    = "web.mp"
  zone_id = aws_route53_zone.mp_priv_hz.id
  type    = "A"
  ttl     = 300
  records = [aws_instance.web_server.private_ip]
}