# Origin Access Control is the modern and secure way to connect CloudFront to S3.
resource "aws_cloudfront_origin_access_control" "example" {
  name                              = "${var.bucket_name}-oac"
  description                       = "OAC for ${var.bucket_name}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.example.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.example.id
    origin_id                = "S3-${var.bucket_name}"
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "S3 Distribution for ${var.bucket_name}"
  default_root_object = var.index_document_suffix

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${var.bucket_name}"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    compress               = true
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  # Restrict viewer access.
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  # Default certificate for https.
  viewer_certificate {
    cloudfront_default_certificate = true
  }
}