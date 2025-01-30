/*resource "aws_appautoscaling_target" "aurora_scaling_target" {
  max_capacity       = 4
  min_capacity       = 1
  resource_id        = "cluster:${aws_rds_cluster.aurora_cluster.cluster_identifier}"
  scalable_dimension = "rds:cluster:ReadReplicaCount"
  service_namespace  = "rds"
  role_arn = "arn:aws:iam::282809433328:role/aws-service-role/rds.application-autoscaling.amazonaws.com/AWSServiceRoleForApplicationAutoScaling_RDSCluster"
}

resource "aws_appautoscaling_policy" "aurora_scaling_policy" {
  name               = "aurora-scaling-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.aurora_scaling_target.resource_id
  scalable_dimension = aws_appautoscaling_target.aurora_scaling_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.aurora_scaling_target.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value       = 70.0
    predefined_metric_specification {
      predefined_metric_type = "RDSReaderAverageCPUUtilization"
    }
    scale_in_cooldown  = 300
    scale_out_cooldown = 300
  }
}
*/