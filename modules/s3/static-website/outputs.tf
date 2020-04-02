output "bucket_domain_name" {
  value       = aws_s3_bucket.default.bucket_domain_name
  description = "FQDN of bucket"
}

output "bucket_website_domain" {
  value       = aws_s3_bucket.default.website_domain
  description = "The domain of the website endpoint"
}

output "bucket_id" {
  value       = aws_s3_bucket.default.id
  description = "Bucket Name (aka ID)"
}

output "bucket_arn" {
  value       = aws_s3_bucket.default.arn
  description = "Bucket ARN"
}