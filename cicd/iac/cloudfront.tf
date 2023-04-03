resource "aws_cloudfront_distribution" "s3_distribution" {
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  aliases             = [aws_route53_record.www.fqdn]

  origin {
    domain_name              = aws_s3_bucket.sp_bucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.cf_origin_ac.id
    origin_id                = "web_server"
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "web_server"
    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id        = data.aws_cloudfront_cache_policy.cache_s3_manages_policy.id
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.cert_us.arn
    minimum_protocol_version = "TLSv1"
    ssl_support_method       = "sni-only"
  }
}

data "aws_cloudfront_cache_policy" "cache_s3_manages_policy" {
  name = "Managed-CachingOptimized"
}

resource "aws_cloudfront_origin_access_control" "cf_origin_ac" {
  name                              = "cf_origin_ac"
  description                       = "CF Origin Policy"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}