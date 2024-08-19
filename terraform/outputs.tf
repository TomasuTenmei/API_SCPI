output "s3_bucket_url" {
  description = "L'URL du bucket S3"
  value       = aws_s3_bucket.static_assets.bucket
}
