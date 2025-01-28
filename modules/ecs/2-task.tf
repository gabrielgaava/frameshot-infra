resource "aws_cloudwatch_log_group" "frameshot-api-log" {
  name              = "/ecs/frameshot-api" 
  retention_in_days = 7                      
}

resource "aws_cloudwatch_log_group" "frameshot-app-log" {
  name              = "/ecs/frameshot-app" 
  retention_in_days = 7                      
}

resource "aws_ecs_task_definition" "frameshot-api-task" {
  family                   = "frameshot-api-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name      = "frameshot-api"
      image     = "${var.api_ecr_url}:latest"
      essential = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/frameshot-api"
          awslogs-region        = "us-east-1"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])

  execution_role_arn = "arn:aws:iam::880591616172:role/LabRole"
  task_role_arn      = "arn:aws:iam::880591616172:role/LabRole"
}

resource "aws_ecs_task_definition" "frameshot-app-task" {
  family                   = "frameshot-app-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name      = "frameshot-app"
      image     = "${var.app_ecr_url}:latest"
      essential = true
      portMappings = [
        {
          containerPort = 3333
          hostPort      = 3333
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/frameshot-app"
          awslogs-region        = "us-east-1"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])

  execution_role_arn = "arn:aws:iam::880591616172:role/LabRole"
  task_role_arn      = "arn:aws:iam::880591616172:role/LabRole"
}

