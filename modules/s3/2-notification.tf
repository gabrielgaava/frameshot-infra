resource "aws_s3_bucket_notification" "object_created_notification" {
  bucket = aws_s3_bucket.bucket.bucket

  queue {
    events = ["s3:ObjectCreated:*"]
    queue_arn = var.notification_queue_arn
    filter_prefix = "videos_input/" 
  }
}