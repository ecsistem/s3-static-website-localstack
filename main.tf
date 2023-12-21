provider "aws" {
  access_key                  = "test"
  secret_key                  = "test"
  region                      = "us-east-1"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    s3 = "http://s3.localhost.localstack.cloud:4566"
  }
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name
  acl    = "public-read"
  tags   = var.tags
}

resource "aws_s3_bucket_website_configuration" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_acl" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id
  acl    = "public-read"
}



resource "aws_s3_object" "object_www" {
  depends_on   = [aws_s3_bucket.s3_bucket]
  for_each     = fileset("${path.root}", "www/*.html")
  bucket       = aws_s3_bucket.s3_bucket.bucket
  key          = basename(each.value)
  source       = each.value
  etag         = filemd5(each.value)
  content_type = "text/html"
  acl          = "public-read"
}
