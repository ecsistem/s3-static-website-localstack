output "website_url" {
  description = "URL do site estático"
  value       = "http://${var.bucket_name}.s3-website.localhost.localstack.cloud:4566/"
}

output "bucket_arn" {
  description = "ARN do bucket"
  value       = aws_s3_bucket.s3_bucket.arn
}

output "bucket_name" {
  description = "Nome do bucket"
  value       = aws_s3_bucket.s3_bucket.bucket
}
