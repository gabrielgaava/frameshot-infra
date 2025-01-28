variable "bucket_name" {
  description = "Name of the bucket"
  type = string
}

variable "notification_queue_arn" {
  description = "The ARN of queue to notify S3 events"
  type = string
}

variable "notification_queue_url" {
  description = "The URL of queue to notify S3 events"
  type = string
}