output "aurora_cluster_endpoint" {
  value = aws_rds_cluster.aurora_cluster.endpoint
}

output "aurora_writer_endpoint" {
  value = aws_rds_cluster_instance.aurora_writer.endpoint
}

output "aurora_reader_endpoints" {
  value = aws_rds_cluster.aurora_cluster.reader_endpoint
}

output "aurora_replica_count" {
  value = length(aws_rds_cluster_instance.aurora_read_replica)
}