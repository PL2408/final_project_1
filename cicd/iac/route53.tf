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