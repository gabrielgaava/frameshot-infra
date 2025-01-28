output "ecs_cluster_name" {
  value = aws_ecs_cluster.ecs_cluster.name
  description = "The name of the ECS cluster"
}

output "ecs_service_frameshot-api" {
  value = aws_ecs_service.fargate_service-api.name
  description = "The name of the ECS service"
}

output "ecs_service_frameshot-app" {
  value = aws_ecs_service.fargate_service-app.name
  description = "The name of the ECS service"
}


output "task_definition_arn-api" {
  value = aws_ecs_task_definition.frameshot-api-task.arn
}

output "task_definition_arn-app" {
  value = aws_ecs_task_definition.frameshot-app-task.arn
}