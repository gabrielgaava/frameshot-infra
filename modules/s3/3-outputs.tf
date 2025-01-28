output "bucker_ur" {
  description = "URLs rof the bucket"
  value       = "https://${aws_s3_bucket.bucket.bucket}.s3.amazonaws.com"
}