output "cognito_user_pool_arn" {
  description = "ARN of the Cognito User Pool"
  value       = aws_cognito_user_pool.user_pool.arn
}

output "cognito_user_pool_login_url" {
  description = "Login URL for the Cognito User Pool Client"
  value       = "https://${aws_cognito_user_pool.user_pool.domain}.auth.${var.aws_region}.amazoncognito.com/login"
}

output "user_pool_client_secret" {
  description = "Client Secret do Client App do Cognito"
  value       = aws_cognito_user_pool_client.user_pool_client.client_secret
  sensitive   = true 
}