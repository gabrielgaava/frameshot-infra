output "repository_urls" {
  description = "URLs repositories created"
  value       = { for name, repo in aws_ecr_repository.repositories : name => repo.repository_url }
}

output "repository_arns" {
  description = "ARNs repositories created"
  value       = { for name, repo in aws_ecr_repository.repositories : name => repo.arn }
}