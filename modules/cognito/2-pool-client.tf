resource "aws_cognito_user_pool_client" "user_pool_client" {
  name         = "${var.name}-client"
  user_pool_id = aws_cognito_user_pool.user_pool.id

  generate_secret = true 

  explicit_auth_flows = [
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_ADMIN_USER_PASSWORD_AUTH"
  ]

  supported_identity_providers = ["COGNITO"] # Usa a UI padrão do Cognito
}

resource "aws_cognito_user_pool_domain" "user_pool_domain" {
  domain       = "${var.name}"
  user_pool_id = aws_cognito_user_pool.user_pool.id
}