resource "aws_cloudfront_origin_access_identity" "_" {
  comment = aws_s3_bucket._.website_endpoint
}

resource "aws_cloudfront_distribution" "_" {
  origin {
    domain_name = aws_s3_bucket._.bucket_regional_domain_name
    origin_id   = aws_s3_bucket._.website_endpoint

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity._.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "my-cloudfront"
  default_root_object = "index.html"

  # Configure logging here if required 	
  #logging_config {
  #  include_cookies = false
  #  bucket          = "mylogs.s3.amazonaws.com"
  #  prefix          = "myprefix"
  #}

  # If you have domain configured use it here 
  aliases = ["${var.purchased_domain}"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket._.website_endpoint

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE", "IN", "IR"]
    }
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate._.arn
    ssl_support_method = "sni-only"
  }

  depends_on = [aws_s3_bucket._, aws_s3_bucket_website_configuration._]
}