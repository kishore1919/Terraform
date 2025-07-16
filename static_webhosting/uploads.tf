locals {
  html_files = fileset("html", "**/*.*")
}

# Iterate over the local HTML files and upload each one to the S3 bucket.
resource "aws_s3_object" "html_uploads" {
  for_each = local.html_files

  bucket = aws_s3_bucket.example.id

  key = "html/${each.value}"

  source = "html/${each.value}"

  etag = filemd5("html/${each.value}")
}