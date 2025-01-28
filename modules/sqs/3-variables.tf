variable "sqs_queues" {
  description = "List of SQS queues with configurations"
  type = list(object({
    name               = string
    is_fifo            = bool
    dead_letter_queue  = bool
  }))
}