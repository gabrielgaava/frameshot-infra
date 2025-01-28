resource "aws_ecs_service" "fargate_service-api" {
  name            = "framesho-api"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.frameshot-api-task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.private_subnets
    security_groups = [aws_security_group.ecs_security_group.id]
    assign_public_ip = true
  }

  depends_on = [
    aws_ecs_cluster.ecs_cluster,
    aws_ecs_task_definition.frameshot-api-task
  ]
}

resource "aws_ecs_service" "fargate_service-app" {
  name            = "framesho-app"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.frameshot-app-task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.private_subnets
    security_groups = [aws_security_group.ecs_security_group.id]
    assign_public_ip = true
  }

  depends_on = [
    aws_ecs_cluster.ecs_cluster,
    aws_ecs_task_definition.frameshot-app-task
  ]
}
