output "website_url" {
  description = "The URL for the CloudFront distribution."
  value       = "https://${aws_cloudfront_distribution.s3_distribution.domain_name}"
}