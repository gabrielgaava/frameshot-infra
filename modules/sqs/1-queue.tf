resource "aws_sqs_queue" "queues" {
  for_each = { for idx, queue in var.sqs_queues : queue.name => queue }

  name                        = each.value.name
  fifo_queue                  = each.value.is_fifo
  content_based_deduplication = each.value.is_fifo ? true : false

  # Se a fila deve ter uma fila morta (Dead Letter Queue)
  redrive_policy = each.value.dead_letter_queue ? jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq[each.key].arn
    maxReceiveCount     = 5
  }) : null

  tags = {
    Name = each.value.name
  }
}

# Criar as filas mortas (DLQ) apenas para as filas que têm a configuração "dead_letter_queue"
resource "aws_sqs_queue" "dlq" {
  for_each = { for idx, queue in var.sqs_queues : queue.name => queue if queue.dead_letter_queue }

  name = "dlq-${each.value.name}"
  fifo_queue = each.value.is_fifo
  content_based_deduplication = each.value.is_fifo ? true : false
}