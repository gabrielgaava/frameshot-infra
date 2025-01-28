variable "private_subnets" {
  description = "List of private subnets"
  type = list(string)
}

variable "vpc_id" {
  description = "VPC ID where the ECS service will run"
  type        = string
}

variable "api_ecr_url" {
  description = "URL of ECR API"
  type        = string
}

variable "app_ecr_url" {
  description = "URL of ECR APP"
  type        = string
}