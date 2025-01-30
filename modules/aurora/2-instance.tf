resource "aws_rds_cluster_instance" "aurora_writer" {
  cluster_identifier = aws_rds_cluster.aurora_cluster.id
  instance_class     = "db.t4g.medium"
  engine            = "aurora-postgresql"
  publicly_accessible = false
}

resource "aws_rds_cluster_instance" "aurora_read_replica" {
  count              = 1
  cluster_identifier = aws_rds_cluster.aurora_cluster.id
  instance_class     = "db.t4g.medium"
  engine            = "aurora-postgresql"
}
