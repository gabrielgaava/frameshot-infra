resource "aws_cognito_user_pool_client" "user_pool_client" {
  name         = "${var.name}-client"
  user_pool_id = aws_cognito_user_pool.user_pool.id

  generate_secret = false 
  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH"
  ] 
  
  callback_urls = ["https://frameshot.com.br/callback"] 
  logout_urls   = ["https://frameshot.com.br/logout"]   
}

resource "aws_cognito_user_pool_domain" "user_pool_domain" {
  domain       = "${var.name}"
  user_pool_id = aws_cognito_user_pool.user_pool.id
}