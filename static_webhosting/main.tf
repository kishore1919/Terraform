resource "aws_s3_bucket" "example" {
  bucket        = var.bucket_name
  tags          = var.tags
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "example" {
  bucket = aws_s3_bucket.example.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.example.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

// The bucket should be private. Block all public access.
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

// This resource is removed and replaced by a bucket policy to grant access to CloudFront.
resource "aws_s3_bucket_policy" "allow_cloudfront_oac" {
  bucket = aws_s3_bucket.example.id
  policy = jsonencode({
    Statement = [{
      Action    = "s3:GetObject",
      Effect    = "Allow",
      Resource  = "${aws_s3_bucket.example.arn}/*",
      Principal = { Service = "cloudfront.amazonaws.com" },
      Condition = { StringEquals = { "AWS:SourceArn" = aws_cloudfront_distribution.s3_distribution.arn } }
    }]
  })
}
