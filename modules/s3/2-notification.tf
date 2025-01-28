resource "aws_sqs_queue_policy" "queue_policy" {
  queue_url = var.notification_queue_url

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          Service = "s3.amazonaws.com"
        },
        Action    = "sqs:SendMessage",
        Resource  = var.notification_queue_arn,
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_s3_bucket.bucket.arn
          }
        }
      }
    ]
  })

  depends_on = [ aws_s3_bucket.bucket ]
}

resource "aws_s3_bucket_notification" "object_created_notification" {
  bucket = aws_s3_bucket.bucket.bucket

  queue {
    events = ["s3:ObjectCreated:*"]
    queue_arn = var.notification_queue_arn
    filter_prefix = "videos_input/" 
  }

  depends_on = [ aws_sqs_queue_policy.queue_policy ]
}
