variable "bucket_name" {
  description = "The unique name of the S3 bucket for static website hosting."
  type        = string
}

variable "region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "us-east-1"
}

variable "tags" {
  description = "A map of tags to assign to the bucket."
  type        = map(string)
  default = {
    Name        = "MyTFExampleBucket"
    Environment = "Dev"
  }
}

variable "index_document_suffix" {
  description = "The file name of the index document for the website."
  type        = string
  default     = "index.html"
}

variable "error_document_key" {
  description = "The file name of the error document for the website."
  type        = string
  default     = "error.html"
}

variable "aws_access_key" {
  description = "AWS access key for authentication"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS secret key for authentication"
  type        = string
  sensitive   = true
}
