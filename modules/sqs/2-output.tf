output "queue_urls" {
  value = { for queue_name, queue in aws_sqs_queue.queues : queue_name => queue.id }
}

output "queue_arns" {
  value = { for queue_name, queue in aws_sqs_queue.queues : queue_name => queue.arn }
}